import 'package:flutter/material.dart';
import '../services/achievements_service.dart';
import '../widgets/banner_ad_widget.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  Set<String> _unlocked = {};
  Map<String, double> _progress = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final unlocked = await AchievementsService.instance.unlocked();
    final progress = <String, double>{};
    for (final a in AchievementsService.all) {
      progress[a.id] = await AchievementsService.instance.progressFor(a);
    }
    if (mounted) {
      setState(() {
        _unlocked = unlocked;
        _progress = progress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final all = AchievementsService.all;
    final unlockedCount = all.where((a) => _unlocked.contains(a.id)).length;
    return Scaffold(
      bottomNavigationBar: const BannerAdWidget(),
      backgroundColor: const Color(0xFF1A0033),
      appBar: AppBar(
        title: const Text('Realizări'),
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A0033), Color(0xFF6A1B9A)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF4081), Color(0xFF7C4DFF)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.emoji_events, color: Colors.white, size: 32),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Progres total',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                            Text('$unlockedCount din ${all.length} realizări',
                                style: const TextStyle(color: Colors.white, fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  itemCount: all.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (ctx, i) {
                    final a = all[i];
                    final unlocked = _unlocked.contains(a.id);
                    final progress = _progress[a.id] ?? 0.0;
                    return Container(
                      decoration: BoxDecoration(
                        color: unlocked ? a.color.withValues(alpha: 0.18) : Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: unlocked ? a.color : Colors.white12,
                          width: unlocked ? 2 : 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: unlocked ? a.color : Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              unlocked ? a.icon : Icons.lock_outline,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(a.title,
                                    style: TextStyle(
                                        color: unlocked ? Colors.white : Colors.white70,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15)),
                                const SizedBox(height: 2),
                                Text(a.description,
                                    style: const TextStyle(color: Colors.white60, fontSize: 12)),
                                const SizedBox(height: 6),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    minHeight: 5,
                                    backgroundColor: Colors.white12,
                                    valueColor: AlwaysStoppedAnimation<Color>(a.color),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (unlocked)
                            const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(Icons.check_circle, color: Colors.greenAccent, size: 24),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
