import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/achievements_service.dart';
import '../services/ads_service.dart';
import '../widgets/banner_ad_widget.dart';

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

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Bubble> _bubbles = [];
  Timer? _spawnTimer;
  Timer? _moveTimer;
  int _score = 0;
  int _high = 0;
  int _missed = 0;
  bool _running = false;
  final _rng = Random();
  int _comboCount = 0;
  DateTime _lastPopAt = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    setState(() => _high = p.getInt('bubblePopHigh') ?? 0);
  }

  Future<void> _saveHigh() async {
    if (_score > _high) {
      _high = _score;
      final p = await SharedPreferences.getInstance();
      await p.setInt('bubblePopHigh', _high);
    }
  }

  void _start() {
    setState(() {
      _bubbles.clear();
      _score = 0;
      _missed = 0;
      _running = true;
    });
    _spawnTimer = Timer.periodic(const Duration(milliseconds: 800), (_) => _spawn());
    _moveTimer = Timer.periodic(const Duration(milliseconds: 30), (_) => _step());
  }

  void _stop() {
    _spawnTimer?.cancel();
    _moveTimer?.cancel();
    _running = false;
    _saveHigh();
    AchievementsService.instance.recordGameEnd(score: _score).then(_showUnlockToasts);
    AdsService.instance.maybeShowInterstitial();
  }

  void _showUnlockToasts(List<Achievement> unlocked) {
    if (unlocked.isEmpty || !mounted) return;
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
                      const Text('🏆 Realizare deblocată',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
                      Text(a.title,
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
    final difficulty = 1 + _score ~/ 100;
    setState(() {
      _bubbles.add(Bubble(
        x: 0.1 + _rng.nextDouble() * 0.8,
        y: 1.05,
        dx: (_rng.nextDouble() - 0.5) * 0.002,
        dy: -0.003 - _rng.nextDouble() * 0.002 - difficulty * 0.0005,
        radius: 28 + _rng.nextDouble() * 18,
        color: _bubbleColors[_rng.nextInt(_bubbleColors.length)],
      ));
    });
  }

  void _step() {
    setState(() {
      for (final b in _bubbles) {
        b.x += b.dx;
        b.y += b.dy;
        if (b.x < 0.05 || b.x > 0.95) b.dx = -b.dx;
      }
      // Remove bubbles that escaped top → missed
      final escaped = _bubbles.where((b) => !b.popped && b.y < -0.1).toList();
      for (final b in escaped) {
        _missed++;
      }
      _bubbles.removeWhere((b) => b.popped || b.y < -0.1);
      if (_missed >= 5) {
        _stop();
        Future.microtask(() {
          if (!mounted) return;
          showDialog(
            context: context,
            builder: (c) => AlertDialog(
              title: const Text('Game Over'),
              content: Text('Scor: $_score${_score == _high ? "\n🏆 Record!" : ""}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(c);
                    _start();
                  },
                  child: const Text('Joc nou'),
                ),
              ],
            ),
          );
        });
      }
    });
  }

  void _pop(int idx, double w, double h) {
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
    });
    _saveHigh();
    AchievementsService.instance.recordPop(currentCombo: _comboCount).then(_showUnlockToasts);
  }

  @override
  void dispose() {
    _spawnTimer?.cancel();
    _moveTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Expanded(child: _stat('SCOR', '$_score')),
                  Expanded(child: _stat('TOP', '$_high')),
                  Expanded(child: _stat('VIEȚI', '${5 - _missed}')),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(builder: (ctx, c) {
                final w = c.maxWidth;
                final h = c.maxHeight;
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1A0033), Color(0xFF6A1B9A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Stack(
                    children: [
                      for (var i = 0; i < _bubbles.length; i++)
                        if (!_bubbles[i].popped)
                          Positioned(
                            left: _bubbles[i].x * w - _bubbles[i].radius,
                            top: _bubbles[i].y * h - _bubbles[i].radius,
                            child: GestureDetector(
                              onTap: () => _pop(i, w, h),
                              child: Container(
                                width: _bubbles[i].radius * 2,
                                height: _bubbles[i].radius * 2,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      _bubbles[i].color.withValues(alpha: 0.9),
                                      _bubbles[i].color.withValues(alpha: 0.5),
                                    ],
                                    center: const Alignment(-0.4, -0.4),
                                    radius: 1.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _bubbles[i].color.withValues(alpha: 0.6),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Container(
                                    width: _bubbles[i].radius * 0.4,
                                    height: _bubbles[i].radius * 0.4,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white24,
                                    ),
                                    margin: EdgeInsets.only(
                                      right: _bubbles[i].radius * 0.4,
                                      bottom: _bubbles[i].radius * 0.4,
                                    ),
                                  ),
                                ),
                              ),
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
                            child: const Text('START'),
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
