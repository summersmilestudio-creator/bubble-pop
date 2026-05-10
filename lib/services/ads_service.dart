import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsService {
  AdsService._();
  static final instance = AdsService._();

  static const String _androidBanner = 'ca-app-pub-5549243085914479/7984658184';
  static const String _androidInterstitial = 'ca-app-pub-5549243085914479/9866311951';
  static const String _androidRewarded = 'ca-app-pub-5549243085914479/7240148614';
  static const String _iosBanner = 'ca-app-pub-5549243085914479/4616258812';
  static const String _iosInterstitial = 'ca-app-pub-5549243085914479/3300903602';
  static const String _iosRewarded = 'ca-app-pub-5549243085914479/4141616093';

  static const String _testBanner = 'ca-app-pub-3940256099942544/6300978111';
  static const String _testInterstitial = 'ca-app-pub-3940256099942544/1033173712';
  static const String _testRewarded = 'ca-app-pub-3940256099942544/5224354917';

  bool _initialized = false;
  InterstitialAd? _interstitial;
  RewardedAd? _rewarded;
  DateTime _lastInterstitialAt = DateTime.fromMillisecondsSinceEpoch(0);
  static const Duration _interstitialCooldown = Duration(seconds: 60);

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

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    await MobileAds.instance.initialize();
    _loadInterstitial();
    _loadRewarded();
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
    RewardedAd.load(
      adUnitId: rewardedUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _rewarded = ad,
        onAdFailedToLoad: (e) => _rewarded = null,
      ),
    );
  }

  void maybeShowInterstitial() {
    if (!_initialized) return;
    final ad = _interstitial;
    if (ad == null) {
      _loadInterstitial();
      return;
    }
    if (DateTime.now().difference(_lastInterstitialAt) < _interstitialCooldown) return;
    _lastInterstitialAt = DateTime.now();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        _interstitial = null;
        _loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (a, _) {
        a.dispose();
        _interstitial = null;
        _loadInterstitial();
      },
    );
    ad.show();
    _interstitial = null;
  }

  Future<bool> showRewarded() async {
    if (!_initialized) return false;
    final ad = _rewarded;
    if (ad == null) {
      _loadRewarded();
      return false;
    }
    bool earned = false;
    final completer = Future<bool>(() async {
      final c = await Future<bool>.delayed(Duration.zero, () {
        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (a) {
            a.dispose();
            _rewarded = null;
            _loadRewarded();
          },
          onAdFailedToShowFullScreenContent: (a, _) {
            a.dispose();
            _rewarded = null;
            _loadRewarded();
          },
        );
        return true;
      });
      if (!c) return false;
      final shown = Future<bool>(() async {
        bool finished = false;
        await ad.show(onUserEarnedReward: (_, __) {
          earned = true;
          finished = true;
        });
        return finished || earned;
      });
      return await shown;
    });
    await completer;
    _rewarded = null;
    return earned;
  }
}
