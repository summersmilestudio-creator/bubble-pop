import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bubble_pop/l10n/app_localizations.dart';
import '../services/achievements_service.dart';
import '../services/ads_service.dart';
import '../services/lives_service.dart';
import '../services/powers_service.dart';
import '../services/rewards_service.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/game_juice.dart';
import 'achievements_screen.dart' show achievementTitle;

const _bubbleColors = [
  Color(0xFFFF4081),
  Color(0xFF7C4DFF),
  Color(0xFF40C4FF),
  Color(0xFF69F0AE),
  Color(0xFFFFD740),
  Color(0xFFFF6E40),
];

class Bubble {
  double x; // 0..1 normalized
  double y; // 0..1 normalized
  double dx;
  double dy;
  double radius;
  Color color;
  bool popped = false;
  Bubble({
    required this.x, required this.y,
    required this.dx, required this.dy,
    required this.radius, required this.color,
  });
}

/// Short-lived pop burst rendered where a bubble was popped.
class _PopFx {
  final double x; // 0..1
  final double y; // 0..1
  final double radius; // px
  final Color color;
  final int startMs;
  _PopFx(this.x, this.y, this.radius, this.color, this.startMs);
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with WidgetsBindingObserver {
  final List<Bubble> _bubbles = [];
  final List<_PopFx> _pops = [];
  Timer? _spawnTimer;
  Timer? _moveTimer;
  int _score = 0;
  int _high = 0;
  int _missed = 0;
  bool _running = false;
  final _rng = Random();
  int _comboCount = 0;
  DateTime _lastPopAt = DateTime.fromMillisecondsSinceEpoch(0);
  int _popsSinceAd = 0;
  static const int _popsPerAd = 20; // full-screen ad every 20 pops; game pauses during the ad

  // Dificultate progresivă: crește puțin la fiecare 5 baloane sparte.
  int _totalPops = 0;
  int _difficultyLevel = 0;
  static const int _popsPerLevel = 5;

  // Câte ratări (baloane scăpate) sunt permise într-o rundă.
  static const int _maxLives = 5;

  // === Energie persistentă + monede + puteri ===
  final _livesSvc = LivesService.instance;
  final _powersSvc = PowersService.instance;
  final _rewards = RewardsService();
  Map<PowerType, int> _powerCounts = {for (final t in PowerType.values) t: 0};

  // === Efecte puteri ===
  DateTime _freezeUntil = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime _slowUntil = DateTime.fromMillisecondsSinceEpoch(0);
  bool _shieldActive = false;

  // Pauză: fie reclama e pe ecran, fie aplicația e în fundal.
  bool _adPaused = false;
  bool _appPaused = false;
  bool get _isPaused => _adPaused || _appPaused;

  bool _reviveBusy = false;
  bool _refillBusy = false;

  /// Multiplicator de viteză dat de puterile Înghețare / Încetinitor.
  double get _speedMul {
    final now = DateTime.now();
    if (now.isBefore(_freezeUntil)) return 0.0;
    if (now.isBefore(_slowUntil)) return 0.5;
    return 1.0;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
    _loadPowers();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final paused = state != AppLifecycleState.resumed;
    if (paused != _appPaused && mounted) {
      setState(() => _appPaused = paused);
    }
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (mounted) setState(() => _high = p.getInt('bubblePopHigh') ?? 0);
  }

  Future<void> _loadPowers() async {
    final counts = await _powersSvc.all();
    if (mounted) setState(() => _powerCounts = counts);
  }

  Future<void> _saveHigh() async {
    if (_score > _high) {
      _high = _score;
      final p = await SharedPreferences.getInstance();
      await p.setInt('bubblePopHigh', _high);
    }
  }

  Duration get _spawnInterval =>
      Duration(milliseconds: max(350, 800 - _difficultyLevel * 20));

  void _rescheduleSpawn() {
    _spawnTimer?.cancel();
    _spawnTimer = Timer.periodic(_spawnInterval, (_) => _spawn());
  }

  void _startTimers() {
    _rescheduleSpawn();
    _moveTimer = Timer.periodic(const Duration(milliseconds: 30), (_) => _step());
  }

  void _resetRound() {
    _bubbles.clear();
    _pops.clear();
    _score = 0;
    _missed = 0;
    _running = true;
    _popsSinceAd = 0;
    _totalPops = 0;
    _difficultyLevel = 0;
    _adPaused = false;
    _shieldActive = false;
    _freezeUntil = DateTime.fromMillisecondsSinceEpoch(0);
    _slowUntil = DateTime.fromMillisecondsSinceEpoch(0);
  }

  /// Pornește o partidă nouă — consumă o viață din energia persistentă.
  Future<void> _start() async {
    final ok = await _livesSvc.consume();
    if (!ok) {
      if (mounted) _showOutOfLives();
      return;
    }
    setState(_resetRound);
    _startTimers();
  }

  /// Refill ratări în timpul jocului prin reclamă recompensată (rundă curentă).
  Future<void> _onRewardedRefillLives() async {
    if (_refillBusy || !_running) return;
    setState(() => _refillBusy = true);
    final earned = await AdsService.instance.showBonusAd();
    if (!mounted) return;
    setState(() {
      _refillBusy = false;
      if (earned) _missed = 0;
    });
    if (!earned && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.adNotAvailable)),
      );
    }
  }

  /// Revenire după Game Over cu o ratare disponibilă (din reclamă). NU consumă
  /// o viață din energie — e plătită prin reclamă.
  void _revive() {
    setState(() {
      _bubbles.clear();
      _pops.clear();
      _missed = _maxLives - 1;
      _running = true;
      _popsSinceAd = 0;
      _adPaused = false;
      _shieldActive = false;
    });
    _startTimers();
  }

  void _cancelTimers() {
    _spawnTimer?.cancel();
    _moveTimer?.cancel();
  }

  void _gameOver() {
    _cancelTimers();
    _running = false;
    _saveHigh();
    AchievementsService.instance.recordGameEnd(score: _score).then(_showUnlockToasts);
    Future.microtask(_showGameOverDialog);
  }

  // ===================== Puteri =====================

  Future<void> _usePower(PowerType t) async {
    if (!_running || _isPaused) return;
    final l = AppLocalizations.of(context)!;
    final ok = await _powersSvc.use(t);
    if (!ok) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.powerNoneLeft(powerName(l, t)))),
        );
      }
      return;
    }
    if (!mounted) return;
    setState(() => _powerCounts[t] = (_powerCounts[t] ?? 1) - 1);
    HapticFeedback.mediumImpact();
    _applyPower(t);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1200),
        backgroundColor: PowersService.specFor(t).color,
        content: Text(l.powerActivated(powerName(l, t))),
      ),
    );
  }

  void _applyPower(PowerType t) {
    final now = DateTime.now();
    switch (t) {
      case PowerType.bomb:
        // Sparge toate baloanele de pe ecran, cu puncte + efect.
        setState(() {
          for (final b in _bubbles) {
            if (b.popped) continue;
            b.popped = true;
            _score += (50 - b.radius).round().clamp(10, 50);
            _totalPops++;
            _pops.add(_PopFx(b.x, b.y, b.radius, b.color, now.millisecondsSinceEpoch));
          }
        });
        break;
      case PowerType.freeze:
        setState(() => _freezeUntil = now.add(const Duration(seconds: 5)));
        break;
      case PowerType.slow:
        setState(() => _slowUntil = now.add(const Duration(seconds: 10)));
        break;
      case PowerType.shield:
        setState(() => _shieldActive = true);
        break;
    }
  }

  // ===================== Dialog fără vieți =====================

  void _showOutOfLives() {
    final l = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (c) => StatefulBuilder(
        builder: (c, setLocal) {
          bool busy = false;
          return AlertDialog(
            title: Text(l.outOfLivesTitle),
            content: Text(l.outOfLivesBody, textAlign: TextAlign.center),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c),
                child: Text(l.waitButton),
              ),
              TextButton.icon(
                icon: const Icon(Icons.monetization_on, color: Color(0xFFFFD740)),
                label: Text(l.coinsLife(LivesService.lifeCoinCost)),
                onPressed: () async {
                  final coins = await _rewards.getCoins();
                  if (coins < LivesService.lifeCoinCost) {
                    if (c.mounted) {
                      ScaffoldMessenger.of(c).showSnackBar(
                        SnackBar(content: Text(l.notEnoughCoins)),
                      );
                    }
                    return;
                  }
                  await _rewards.addCoins(-LivesService.lifeCoinCost);
                  await _livesSvc.add(1);
                  if (c.mounted) Navigator.pop(c);
                  _start();
                },
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4081),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.favorite),
                label: Text(l.watchAdLife),
                onPressed: () async {
                  if (busy) return;
                  setLocal(() => busy = true);
                  final earned = await AdsService.instance.showBonusAd();
                  if (earned) {
                    await _livesSvc.add(1);
                    if (c.mounted) Navigator.pop(c);
                    _start();
                  } else {
                    setLocal(() => busy = false);
                    if (c.mounted) {
                      ScaffoldMessenger.of(c).showSnackBar(
                        SnackBar(content: Text(l.adNotAvailable)),
                      );
                    }
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _showGameOverDialog() {
    if (!mounted) return;
    final l = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) => StatefulBuilder(
        builder: (c, setLocal) => AlertDialog(
          title: Text(l.gameOver),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${l.scoreResult(_score)}${_score == _high ? "\n${l.newRecord}" : ""}',
                  textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Text(
                l.lifeRegenHint,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: _reviveBusy
                  ? null
                  : () {
                      Navigator.pop(c);
                      _start();
                    },
              child: Text(l.playAgain),
            ),
            ElevatedButton.icon(
              onPressed: _reviveBusy
                  ? null
                  : () async {
                      setLocal(() => _reviveBusy = true);
                      final earned = await AdsService.instance.showBonusAd();
                      _reviveBusy = false;
                      if (!c.mounted) return;
                      if (earned) {
                        Navigator.pop(c);
                        _revive();
                      } else {
                        setLocal(() {});
                        ScaffoldMessenger.of(c).showSnackBar(
                          SnackBar(content: Text(l.adNotAvailable)),
                        );
                      }
                    },
              icon: _reviveBusy
                  ? const SizedBox(
                      width: 16, height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.favorite),
              label: Text(l.reviveWithAd),
            ),
          ],
        ),
      ),
    );
  }

  void _showUnlockToasts(List<Achievement> unlocked) {
    if (unlocked.isEmpty || !mounted) return;
    final l = AppLocalizations.of(context)!;
    for (var i = 0; i < unlocked.length; i++) {
      final a = unlocked[i];
      Future.delayed(Duration(milliseconds: 200 + i * 1500), () {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: a.color,
            duration: const Duration(milliseconds: 2200),
            content: Row(
              children: [
                Icon(a.icon, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(l.achievementUnlocked,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
                      Text(achievementTitle(l, a.id),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }
  }

  void _spawn() {
    if (!_running || _isPaused) return;
    setState(() {
      _bubbles.add(Bubble(
        x: 0.1 + _rng.nextDouble() * 0.8,
        y: 1.05,
        dx: (_rng.nextDouble() - 0.5) * 0.002,
        dy: -0.003 - _rng.nextDouble() * 0.002 - _difficultyLevel * 0.00035,
        radius: 28 + _rng.nextDouble() * 18,
        color: _bubbleColors[_rng.nextInt(_bubbleColors.length)],
      ));
    });
  }

  void _step() {
    if (!_running || _isPaused) return;
    final mul = _speedMul;
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      for (final b in _bubbles) {
        b.x += b.dx * mul;
        b.y += b.dy * mul;
        if (b.x < 0.05 || b.x > 0.95) b.dx = -b.dx;
      }
      final escaped = _bubbles.where((b) => !b.popped && b.y < -0.1).toList();
      for (final _ in escaped) {
        if (_shieldActive) {
          _shieldActive = false; // scutul absoarbe o ratare
        } else {
          _missed++;
        }
      }
      _bubbles.removeWhere((b) => b.popped || b.y < -0.1);
      // Curăță efectele de spargere expirate (300 ms).
      _pops.removeWhere((p) => nowMs - p.startMs > 300);
      if (_missed >= _maxLives) {
        _gameOver();
      }
    });
  }

  void _pop(int idx) {
    if (_isPaused || !_running) return;
    final b = _bubbles[idx];
    if (b.popped) return;
    HapticFeedback.lightImpact();
    final now = DateTime.now();
    if (now.difference(_lastPopAt) < const Duration(seconds: 2)) {
      _comboCount++;
    } else {
      _comboCount = 1;
    }
    _lastPopAt = now;
    setState(() {
      b.popped = true;
      _score += (50 - b.radius).round().clamp(10, 50);
      _totalPops++;
      _pops.add(_PopFx(b.x, b.y, b.radius, b.color, now.millisecondsSinceEpoch));
    });
    final newLevel = _totalPops ~/ _popsPerLevel;
    if (newLevel != _difficultyLevel) {
      _difficultyLevel = newLevel;
      if (_running) _rescheduleSpawn();
    }
    _saveHigh();
    AchievementsService.instance.recordPop(currentCombo: _comboCount).then(_showUnlockToasts);
    _popsSinceAd++;
    if (_popsSinceAd >= _popsPerAd) {
      _popsSinceAd = 0;
      AdsService.instance.maybeShowInterstitial(
        onShown: () {
          if (mounted) setState(() => _adPaused = true);
        },
        onDismissed: () {
          if (mounted) setState(() => _adPaused = false);
        },
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cancelTimers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      bottomNavigationBar: const BannerAdWidget(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                border: const Border(bottom: BorderSide(color: Colors.white12)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    iconSize: 22,
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: _stat(l.statScore, '$_score')),
                  Expanded(child: _stat(l.statTop, '$_high')),
                  Expanded(child: _stat(l.statLives, '${_maxLives - _missed}')),
                  Expanded(child: _stat(l.statLevel, '${_difficultyLevel + 1}')),
                  if (_running && _missed >= 2)
                    IconButton(
                      tooltip: l.refillLivesTooltip,
                      iconSize: 22,
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(),
                      onPressed: _refillBusy ? null : _onRewardedRefillLives,
                      icon: _refillBusy
                          ? const SizedBox(
                              width: 18, height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.favorite, color: Color(0xFFFF4081)),
                    ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(builder: (ctx, c) {
                final w = c.maxWidth;
                final h = c.maxHeight;
                return AnimatedGradientBackground(
                  colors: const [Color(0xFF1A0033), Color(0xFF311B92), Color(0xFF6A1B9A)],
                  child: Stack(
                    children: [
                      for (var i = 0; i < _bubbles.length; i++)
                        if (!_bubbles[i].popped)
                          Positioned(
                            left: _bubbles[i].x * w - _bubbles[i].radius,
                            top: _bubbles[i].y * h - _bubbles[i].radius,
                            child: GestureDetector(
                              onTap: () => _pop(i),
                              child: CustomPaint(
                                size: Size(_bubbles[i].radius * 2, _bubbles[i].radius * 2),
                                painter: _BubblePainter(_bubbles[i].color),
                              ),
                            ),
                          ),
                      // Efecte de spargere (deasupra baloanelor).
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _PopPainter(_pops, w, h,
                                DateTime.now().millisecondsSinceEpoch),
                          ),
                        ),
                      ),
                      if (_shieldActive && _running)
                        Positioned(
                          top: 8, left: 0, right: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFFFFD740)),
                              ),
                              child: Text(l.shieldActive,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                            ),
                          ),
                        ),
                      if (_isPaused && _running)
                        Center(
                          child: Text(l.paused,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                        ),
                      // Bara de puteri (doar în timpul jocului).
                      if (_running)
                        Positioned(
                          left: 0, right: 0, bottom: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (final spec in PowersService.specs)
                                _powerChip(spec),
                            ],
                          ),
                        ),
                      if (!_running)
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF4081),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                              textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                            ),
                            onPressed: _start,
                            child: Text(l.start),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _powerChip(PowerSpec spec) {
    final count = _powerCounts[spec.type] ?? 0;
    final enabled = count > 0;
    return PressableScale(
      onTap: () => _usePower(spec.type),
      child: Opacity(
        opacity: enabled ? 1.0 : 0.45,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [spec.color, spec.color.withValues(alpha: 0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
                boxShadow: [
                  BoxShadow(color: spec.color.withValues(alpha: 0.5), blurRadius: 8),
                ],
              ),
              child: Icon(spec.icon, color: Colors.white, size: 28),
            ),
            Positioned(
              right: -4, top: -4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white30),
                ),
                child: Text('$count',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1)),
        Text(value, style: const TextStyle(color: Color(0xFFFF4081), fontSize: 18, fontWeight: FontWeight.w900)),
      ],
    );
  }
}

/// Glossy bubble: translucent body with a radial gradient, rim light, a soft
/// specular highlight and a tiny sparkle — far richer than a flat circle.
class _BubblePainter extends CustomPainter {
  final Color color;
  _BubblePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2;
    final c = Offset(r, r);

    // Soft outer glow.
    canvas.drawCircle(
      c, r * 0.96,
      Paint()
        ..color = color.withValues(alpha: 0.40)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );

    // Translucent body.
    canvas.drawCircle(
      c, r * 0.96,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.4, -0.5),
          radius: 1.05,
          colors: [
            Colors.white.withValues(alpha: 0.95),
            color.withValues(alpha: 0.95),
            color.withValues(alpha: 0.80),
          ],
          stops: const [0.0, 0.45, 1.0],
        ).createShader(Rect.fromCircle(center: c, radius: r)),
    );

    // Rim light.
    canvas.drawCircle(
      c, r * 0.90,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.07
        ..color = Colors.white.withValues(alpha: 0.45),
    );

    // Specular highlight (top-left).
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(r * 0.68, r * 0.58), width: r * 0.55, height: r * 0.38),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.85)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5),
    );

    // Tiny sparkle (bottom-right).
    canvas.drawCircle(
      Offset(r * 1.35, r * 0.85), r * 0.07,
      Paint()..color = Colors.white.withValues(alpha: 0.7),
    );
  }

  @override
  bool shouldRepaint(covariant _BubblePainter old) => old.color != color;
}

/// Expanding fading rings + spray dots where bubbles popped.
class _PopPainter extends CustomPainter {
  final List<_PopFx> pops;
  final double w;
  final double h;
  final int nowMs;
  _PopPainter(this.pops, this.w, this.h, this.nowMs);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in pops) {
      final t = ((nowMs - p.startMs) / 300).clamp(0.0, 1.0);
      final center = Offset(p.x * w, p.y * h);
      final ringR = p.radius * (0.6 + 1.6 * t);
      final alpha = (1 - t);
      // Ring.
      canvas.drawCircle(
        center, ringR,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = p.radius * 0.18 * (1 - t)
          ..color = p.color.withValues(alpha: alpha * 0.8),
      );
      // Spray dots.
      for (var k = 0; k < 6; k++) {
        final ang = (k / 6) * 2 * pi;
        final dotR = p.radius * (0.25 * (1 - t));
        final dist = ringR * 0.9;
        canvas.drawCircle(
          center + Offset(cos(ang) * dist, sin(ang) * dist),
          dotR,
          Paint()..color = p.color.withValues(alpha: alpha),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PopPainter old) => true;
}
