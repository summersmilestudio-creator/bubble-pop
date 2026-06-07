import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bubble_pop/l10n/app_localizations.dart';
import '../services/rewards_service.dart';
import '../services/lives_service.dart';
import '../services/ads_service.dart';
import '../services/purchase_service.dart';
import '../services/locale_controller.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/daily_reward_screen.dart';
import '../widgets/game_juice.dart';
import '../widgets/language_picker.dart';
import 'achievements_screen.dart';
import 'game_screen.dart';
import 'settings_screen.dart';
import 'shop_screen.dart';

/// Coins granted for watching the home-screen rewarded ad.
const int kAdCoinReward = 10;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final _rewards = RewardsService();
  final _lives = LivesService.instance;
  int _coins = 0;
  int _highScore = 0;
  int _livesCount = LivesService.maxLives;
  int _msToNext = 0;
  bool _adBusy = false;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkDaily();
    // Refresh lives + countdown once per second.
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _refreshLives());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refreshLives();
  }

  Future<void> _checkDaily() async {
    final r = await _rewards.claimDailyIfAvailable();
    if (r.reward > 0 && mounted) {
      await Navigator.push(context, MaterialPageRoute(
          builder: (_) => DailyRewardScreen(
              day: r.day, reward: r.reward, primaryColor: const Color(0xFFFF4081))));
    }
    _load();
  }

  Future<void> _load() async {
    final c = await _rewards.getCoins();
    final p = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _coins = c;
        _highScore = p.getInt('bubblePopHigh') ?? 0;
      });
    }
    _refreshLives();
  }

  Future<void> _refreshLives() async {
    final lives = await _lives.getLives();
    final ms = await _lives.millisToNextLife();
    if (mounted) {
      setState(() {
        _livesCount = lives;
        _msToNext = ms;
      });
    }
  }

  String _fmt(int ms) {
    final total = (ms / 1000).ceil();
    final m = total ~/ 60;
    final s = total % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Future<void> _watchAdForCoins() async {
    if (_adBusy) return;
    setState(() => _adBusy = true);
    final earned = await AdsService.instance.showRewarded();
    if (!mounted) return;
    if (earned) {
      await _rewards.addCoins(kAdCoinReward);
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFFFF6F00),
            content: Text(AppLocalizations.of(context)!.coinsEarned(kAdCoinReward)),
          ),
        );
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.adNotAvailable)),
      );
    }
    if (mounted) setState(() => _adBusy = false);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      bottomNavigationBar: const BannerAdWidget(),
      body: AnimatedGradientBackground(
        colors: const [Color(0xFF1A0033), Color(0xFF4A148C), Color(0xFF1A0033)],
        child: Stack(
          children: [
            const Positioned.fill(child: _FloatingBubbles()),
            SafeArea(
              child: LayoutBuilder(
                builder: (ctx, cns) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: cns.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.settings, color: Colors.white),
                              onPressed: () async {
                                await Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => const SettingsScreen()));
                                _load();
                              },
                            ),
                            IconButton(
                              tooltip: l.tooltipAchievements,
                              icon: const Icon(Icons.emoji_events, color: Color(0xFFFFCA28)),
                              onPressed: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const AchievementsScreen())),
                            ),
                            IconButton(
                              tooltip: l.tooltipShop,
                              icon: const Icon(Icons.shopping_bag, color: Color(0xFFFF4081)),
                              onPressed: () async {
                                await Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => const ShopScreen()));
                                _load();
                              },
                            ),
                            IconButton(
                              tooltip: l.language,
                              icon: Text(
                                LocaleController.flagFor(
                                    Localizations.localeOf(context).languageCode),
                                style: const TextStyle(fontSize: 22),
                              ),
                              onPressed: () => showLanguagePicker(context),
                            ),
                          ],
                        ),
                        _coinBadge(),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF7C4DFF).withValues(alpha: 0.45),
                              blurRadius: 55, spreadRadius: 2),
                          BoxShadow(
                              color: const Color(0xFFFF4081).withValues(alpha: 0.30),
                              blurRadius: 35),
                        ],
                      ),
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (r) => const LinearGradient(
                              colors: [Color(0xFFFF80AB), Color(0xFF7C4DFF)],
                            ).createShader(r),
                            child: const Text('BUBBLE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 64, fontWeight: FontWeight.w900,
                                    color: Colors.white, letterSpacing: 6, height: 0.9)),
                          ),
                          ShaderMask(
                            shaderCallback: (r) => const LinearGradient(
                              colors: [Color(0xFF7C4DFF), Color(0xFFFF80AB)],
                            ).createShader(r),
                            child: const Text('POP',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 64, fontWeight: FontWeight.w900,
                                    color: Colors.white, letterSpacing: 6, height: 0.9)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _livesCard(l),
                    const SizedBox(height: 14),
                    _scoreCard(l),
                    const Spacer(),
                    _removeAdsButton(l),
                    _adCoinsButton(l),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF4081),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 12,
                          shadowColor: const Color(0xFFFF4081),
                        ),
                        onPressed: () async {
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const GameScreen()));
                          _load();
                        },
                        child: Text(l.newGame),
                      ),
                    ),
                    const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _coinBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFD740)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.monetization_on, color: Color(0xFFFFD740), size: 20),
          const SizedBox(width: 6),
          Text('$_coins',
              style: const TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _livesCard(AppLocalizations l) {
    final full = _livesCount >= LivesService.maxLives;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white.withValues(alpha: 0.13), Colors.white.withValues(alpha: 0.03)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFF4081).withValues(alpha: 0.45)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 14, offset: const Offset(0, 8)),
          BoxShadow(color: const Color(0xFFFF4081).withValues(alpha: 0.18), blurRadius: 22),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < LivesService.maxLives; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Icon(
                    i < _livesCount ? Icons.favorite : Icons.favorite_border,
                    color: i < _livesCount ? const Color(0xFFFF4081) : Colors.white30,
                    size: 26,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            full ? l.livesFull : l.nextLifeIn(_fmt(_msToNext)),
            style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _scoreCard(AppLocalizations l) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white.withValues(alpha: 0.13), Colors.white.withValues(alpha: 0.03)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF7C4DFF).withValues(alpha: 0.45)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 14, offset: const Offset(0, 8)),
          BoxShadow(color: const Color(0xFF7C4DFF).withValues(alpha: 0.18), blurRadius: 22),
        ],
      ),
      child: Column(
        children: [
          Text(l.topScore,
              style: const TextStyle(color: Colors.white60, fontSize: 12, letterSpacing: 2)),
          const SizedBox(height: 4),
          Text('$_highScore',
              style: const TextStyle(
                  color: Color(0xFFFF4081), fontSize: 36, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _adCoinsButton(AppLocalizations l) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFFFD740),
          side: const BorderSide(color: Color(0xFFFFD740), width: 2),
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: _adBusy ? null : _watchAdForCoins,
        icon: _adBusy
            ? const SizedBox(
                width: 18, height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFFFD740)))
            : const Icon(Icons.play_circle_fill),
        label: Text(l.watchAdForCoins(kAdCoinReward)),
      ),
    );
  }

  Widget _removeAdsButton(AppLocalizations l) {
    final svc = PurchaseService.instance;
    return ValueListenableBuilder<bool>(
      valueListenable: svc.noAdsNotifier,
      builder: (ctx, noAds, _) {
        if (noAds) return const SizedBox.shrink();
        final price = svc.productFor(PurchaseService.noAdsId)?.price;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF43A047),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 8,
                shadowColor: const Color(0xFF43A047),
              ),
              onPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ShopScreen()));
                _load();
              },
              icon: const Icon(Icons.block),
              label: Text(price != null ? '${l.removeAds} • $price' : l.removeAds),
            ),
          ),
        );
      },
    );
  }
}

/// Decorative slowly-rising bubbles behind the menu — pure Flutter, cheap.
class _FloatingBubbles extends StatefulWidget {
  const _FloatingBubbles();

  @override
  State<_FloatingBubbles> createState() => _FloatingBubblesState();
}

class _FloatingBubblesState extends State<_FloatingBubbles>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  final _rnd = math.Random(7);
  late final List<_Deco> _deco;

  @override
  void initState() {
    super.initState();
    _deco = List.generate(14, (i) {
      return _Deco(
        x: _rnd.nextDouble(),
        phase: _rnd.nextDouble(),
        speed: 0.4 + _rnd.nextDouble() * 0.8,
        size: 18 + _rnd.nextDouble() * 46,
        color: _palette[i % _palette.length],
      );
    });
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 14))..repeat();
  }

  static const _palette = [
    Color(0xFFFF4081), Color(0xFF7C4DFF), Color(0xFF40C4FF),
    Color(0xFF69F0AE), Color(0xFFFFD740), Color(0xFFFF6E40),
  ];

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, __) => CustomPaint(
          size: Size.infinite,
          painter: _DecoPainter(_deco, _c.value),
        ),
      ),
    );
  }
}

class _Deco {
  final double x, phase, speed, size;
  final Color color;
  _Deco({required this.x, required this.phase, required this.speed, required this.size, required this.color});
}

class _DecoPainter extends CustomPainter {
  final List<_Deco> deco;
  final double t;
  _DecoPainter(this.deco, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    for (final d in deco) {
      final prog = (t * d.speed + d.phase) % 1.0;
      final y = size.height * (1.1 - 1.2 * prog);
      final x = size.width * d.x + math.sin(prog * 6.28 + d.phase * 6.28) * 16;
      final alpha = (0.10 + 0.10 * math.sin(prog * 3.14)).clamp(0.0, 0.22);
      canvas.drawCircle(
        Offset(x, y), d.size,
        Paint()
          ..color = d.color.withValues(alpha: alpha)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DecoPainter old) => old.t != t;
}
