import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'purchase_service.dart';

class AdsService {
  AdsService._();
  static final instance = AdsService._();

  static const String _androidBanner = 'ca-app-pub-5549243085914479/7984658184';
  static const String _androidInterstitial = 'ca-app-pub-5549243085914479/9866311951';
  static const String _androidRewarded = 'ca-app-pub-5549243085914479/7240148614';
  static const String _iosBanner = 'ca-app-pub-5549243085914479/4616258812';
  static const String _iosInterstitial = 'ca-app-pub-5549243085914479/3300903602';
  static const String _iosRewarded = 'ca-app-pub-5549243085914479/4141616093';

  // Rewarded Interstitial — cel mai mare eCPM. iOS real (2026-06-15).
  // Android nu are încă unitate → null (nu se încarcă, fallback la rewarded).
  static const String _rewardedInterstitialIOS = 'ca-app-pub-5549243085914479/5567562579';
  static const String _rewardedInterstitialTest = 'ca-app-pub-3940256099942544/5354046379';

  // App Open (highest-value launch/return ad). Replace the two prod IDs with the
  // real AdMob App Open units before release.
  static const String _appOpenProdAndroid = 'ca-app-pub-5549243085914479/APPOPEN_ANDROID';
  static const String _appOpenProdIOS = 'ca-app-pub-5549243085914479/1165241571';

  static const String _testBanner = 'ca-app-pub-3940256099942544/6300978111';
  static const String _testInterstitial = 'ca-app-pub-3940256099942544/1033173712';
  static const String _testRewarded = 'ca-app-pub-3940256099942544/5224354917';
  static const String _appOpenTestAndroid = 'ca-app-pub-3940256099942544/9257395921';
  static const String _appOpenTestIOS = 'ca-app-pub-3940256099942544/5575463023';

  static const Duration _appOpenMaxAge = Duration(hours: 4);
  static const Duration _rewIntCooldown = Duration(minutes: 2);

  bool _initialized = false;
  InterstitialAd? _interstitial;
  RewardedAd? _rewarded;
  bool _rewardedLoading = false;
  int _rewardedRetry = 0;
  Completer<bool>? _rewardedLoadCompleter;
  RewardedInterstitialAd? _rewardedInterstitial;
  bool _rewardedInterstitialLoading = false;
  DateTime? _lastRewIntShown;
  AppOpenAd? _appOpen;
  bool _appOpenLoading = false;
  DateTime? _appOpenLoadTime;
  bool _showingFullScreenAd = false;

  // Single global gate across ALL full-screen ads (interstitial, app-open,
  // rewarded). After any full-screen ad is shown we refuse to show another one
  // for [_globalAdCooldown]. This is what stops the "multiple consecutive ads"
  // experience Apple flagged (e.g. game-over interstitial immediately followed
  // by an app-open on resume).
  DateTime _lastFullScreenAt = DateTime.fromMillisecondsSinceEpoch(0);
  static const Duration _globalAdCooldown = Duration(seconds: 45);
  bool get _recentlyShowedFullScreen =>
      DateTime.now().difference(_lastFullScreenAt) < _globalAdCooldown;
  void _markFullScreenShown() => _lastFullScreenAt = DateTime.now();

  /// Bumped whenever a full-screen ad (App Open or interstitial) closes, so the
  /// UI can offer the "Remove ads" upsell right after.
  final ValueNotifier<int> adClosedTick = ValueNotifier(0);
  void _notifyAdClosed() => adClosedTick.value++;

  String get bannerUnitId {
    if (kDebugMode) return _testBanner;
    return Platform.isIOS ? _iosBanner : _androidBanner;
  }

  String get interstitialUnitId {
    if (kDebugMode) return _testInterstitial;
    return Platform.isIOS ? _iosInterstitial : _androidInterstitial;
  }

  String get rewardedUnitId {
    if (kDebugMode) return _testRewarded;
    return Platform.isIOS ? _iosRewarded : _androidRewarded;
  }

  String get appOpenUnitId {
    if (kDebugMode) return Platform.isIOS ? _appOpenTestIOS : _appOpenTestAndroid;
    return Platform.isIOS ? _appOpenProdIOS : _appOpenProdAndroid;
  }

  String? get rewardedInterstitialUnitId {
    if (kDebugMode) return _rewardedInterstitialTest;
    return Platform.isIOS ? _rewardedInterstitialIOS : null;
  }

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    await MobileAds.instance.initialize();
    _loadInterstitial();
    _loadRewarded();
    _loadRewardedInterstitial();
    loadAppOpen();
  }

  void loadAppOpen() {
    if (_appOpenLoading || _appOpen != null) return;
    _appOpenLoading = true;
    AppOpenAd.load(
      adUnitId: appOpenUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpen = ad;
          _appOpenLoadTime = DateTime.now();
          _appOpenLoading = false;
        },
        onAdFailedToLoad: (err) {
          _appOpen = null;
          _appOpenLoading = false;
        },
      ),
    );
  }

  bool get _appOpenValid =>
      _appOpen != null &&
      _appOpenLoadTime != null &&
      DateTime.now().difference(_appOpenLoadTime!) < _appOpenMaxAge;

  /// Shows the App Open ad on app foreground if one is ready. Skips when ads are
  /// removed, another full-screen ad is showing, or none is loaded (then preloads).
  Future<void> showAppOpenIfReady() async {
    if (!_initialized || PurchaseService.instance.noAds) return;
    if (_showingFullScreenAd) return;
    // Don't stack an app-open right after another full-screen ad.
    if (_recentlyShowedFullScreen) return;
    if (!_appOpenValid) {
      loadAppOpen();
      return;
    }
    final ad = _appOpen!;
    _appOpen = null;
    _showingFullScreenAd = true;
    _markFullScreenShown();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        _showingFullScreenAd = false;
        loadAppOpen();
        _notifyAdClosed();
      },
      onAdFailedToShowFullScreenContent: (a, _) {
        a.dispose();
        _showingFullScreenAd = false;
        loadAppOpen();
      },
    );
    await ad.show();
  }

  void _loadInterstitial() {
    InterstitialAd.load(
      adUnitId: interstitialUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitial = ad,
        onAdFailedToLoad: (e) => _interstitial = null,
      ),
    );
  }

  void _loadRewarded() {
    if (_rewardedLoading || _rewarded != null) return;
    _rewardedLoading = true;
    RewardedAd.load(
      adUnitId: rewardedUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewarded = ad;
          _rewardedLoading = false;
          _rewardedRetry = 0;
          final c = _rewardedLoadCompleter;
          if (c != null && !c.isCompleted) c.complete(true);
        },
        onAdFailedToLoad: (e) {
          _rewarded = null;
          _rewardedLoading = false;
          final c = _rewardedLoadCompleter;
          if (c != null && !c.isCompleted) c.complete(false);
          // Auto-retry with backoff so a transient no-fill doesn't leave the
          // user permanently without a rewarded ad.
          if (_rewardedRetry < 4) {
            _rewardedRetry++;
            Future.delayed(Duration(seconds: 3 * _rewardedRetry), () {
              if (_rewarded == null) _loadRewarded();
            });
          }
        },
      ),
    );
  }

  /// Makes sure a rewarded ad is ready, loading on demand and waiting up to
  /// [timeout] for an in-flight load to finish. Returns true if one is ready.
  Future<bool> _ensureRewarded(
      {Duration timeout = const Duration(seconds: 9)}) async {
    if (_rewarded != null) return true;
    final c = (_rewardedLoadCompleter != null &&
            !_rewardedLoadCompleter!.isCompleted)
        ? _rewardedLoadCompleter!
        : (_rewardedLoadCompleter = Completer<bool>());
    _loadRewarded();
    try {
      await c.future.timeout(timeout);
    } catch (_) {/* timeout — fall through */}
    return _rewarded != null;
  }

  /// [onShown] e apelat DOAR dacă reclama chiar se afișează (ca să poată
  /// pune jocul pe pauză); [onDismissed] la închiderea/eșecul reclamei
  /// (ca să reia jocul). Dacă reclama nu se afișează (cooldown, neîncărcată,
  /// noAds), niciun callback nu e apelat și jocul continuă normal.
  ///
  /// [bypassCooldown] ignoră cooldown-ul global de 45s — folosit pentru
  /// reclama periodică de gameplay (la fiecare 20 de baloane sparte), care
  /// trebuie să apară de fiecare dată, nu doar prima oară. Chiar și așa, nu se
  /// suprapune NICIODATĂ peste o altă reclamă full-screen care e deja pe ecran.
  ///
  /// Returnează `true` dacă reclama chiar a început să se afișeze, `false`
  /// altfel (neîncărcată, noAds, suprapunere) — apelantul poate reîncerca.
  bool maybeShowInterstitial(
      {VoidCallback? onShown,
      VoidCallback? onDismissed,
      bool bypassCooldown = false}) {
    if (!_initialized) return false;
    if (PurchaseService.instance.noAds) return false;
    // Never stack on top of another full-screen ad that's already showing.
    if (_showingFullScreenAd) return false;
    // Respectă cooldown-ul global doar dacă nu e cerut bypass explicit.
    if (!bypassCooldown && _recentlyShowedFullScreen) return false;
    final ad = _interstitial;
    if (ad == null) {
      _loadInterstitial();
      return false;
    }
    _showingFullScreenAd = true;
    _markFullScreenShown();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        _interstitial = null;
        _showingFullScreenAd = false;
        _loadInterstitial();
        onDismissed?.call();
        _notifyAdClosed();
      },
      onAdFailedToShowFullScreenContent: (a, _) {
        a.dispose();
        _interstitial = null;
        _showingFullScreenAd = false;
        _loadInterstitial();
        onDismissed?.call();
      },
    );
    // Punem jocul pe pauză chiar înainte de afișare, ca baloanele să nu
    // mai urce „în spatele" reclamei și să consume vieți.
    onShown?.call();
    ad.show();
    _interstitial = null;
    return true;
  }

  Future<bool> showRewarded() async {
    if (!_initialized) return false;
    // Don't overlap another full-screen ad that is already on screen.
    if (_showingFullScreenAd) return false;
    // Try to load on demand (and wait) instead of failing instantly.
    await _ensureRewarded();
    final ad = _rewarded;
    if (ad == null) {
      _loadRewarded();
      return false;
    }
    final completer = Completer<bool>();
    _showingFullScreenAd = true;
    // Mark so an automatic interstitial/app-open won't fire right after.
    _markFullScreenShown();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        _rewarded = null;
        _showingFullScreenAd = false;
        _loadRewarded();
        if (!completer.isCompleted) completer.complete(false);
      },
      onAdFailedToShowFullScreenContent: (a, _) {
        a.dispose();
        _rewarded = null;
        _showingFullScreenAd = false;
        _loadRewarded();
        if (!completer.isCompleted) completer.complete(false);
      },
    );
    await ad.show(onUserEarnedReward: (_, __) {
      if (!completer.isCompleted) completer.complete(true);
    });
    return completer.future;
  }

  // ---- Rewarded Interstitial (eCPM cel mai mare) ----------------------------
  void _loadRewardedInterstitial() {
    final id = rewardedInterstitialUnitId;
    if (id == null) return;
    if (_rewardedInterstitialLoading || _rewardedInterstitial != null) return;
    _rewardedInterstitialLoading = true;
    RewardedInterstitialAd.load(
      adUnitId: id,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) { _rewardedInterstitial = ad; _rewardedInterstitialLoading = false; },
        onAdFailedToLoad: (err) { _rewardedInterstitial = null; _rewardedInterstitialLoading = false; },
      ),
    );
  }

  bool get _rewIntReady => _rewardedInterstitial != null;
  bool get _rewIntOffCooldown =>
      _lastRewIntShown == null ||
      DateTime.now().difference(_lastRewIntShown!) >= _rewIntCooldown;

  Future<bool> _showRewardedInterstitial() async {
    final ad = _rewardedInterstitial;
    if (ad == null) { _loadRewardedInterstitial(); return false; }
    final completer = Completer<bool>();
    _showingFullScreenAd = true;
    _markFullScreenShown();
    _lastRewIntShown = DateTime.now();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose(); _rewardedInterstitial = null;
        _showingFullScreenAd = false;
        _loadRewardedInterstitial();
        _notifyAdClosed();
        if (!completer.isCompleted) completer.complete(false);
      },
      onAdFailedToShowFullScreenContent: (a, _) {
        a.dispose(); _rewardedInterstitial = null;
        _showingFullScreenAd = false;
        _loadRewardedInterstitial();
        if (!completer.isCompleted) completer.complete(false);
      },
    );
    await ad.show(onUserEarnedReward: (_, __) {
      if (!completer.isCompleted) completer.complete(true);
    });
    return completer.future;
  }

  /// Recompensă opt-in: preferă Rewarded Interstitial (eCPM mult mai mare) când
  /// e disponibil și off-cooldown, altfel cade pe Rewarded normal. Apelat doar
  /// din butoane „vezi reclamă" => conform politicii AdMob.
  Future<bool> showBonusAd() async {
    if (!_showingFullScreenAd && _rewIntReady && _rewIntOffCooldown) {
      return _showRewardedInterstitial();
    }
    return showRewarded();
  }
}
