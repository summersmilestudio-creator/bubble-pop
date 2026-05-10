import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Achievement {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int target;
  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.target,
  });
}

class AchievementsService {
  AchievementsService._();
  static final instance = AchievementsService._();

  static const _kTotalPoppedKey = 'achTotalPopped';
  static const _kBestScoreKey = 'achBestScore';
  static const _kBestComboKey = 'achBestCombo';
  static const _kGamesPlayedKey = 'achGamesPlayed';
  static const _kUnlockedKey = 'achUnlocked';

  static const List<Achievement> all = [
    Achievement(
      id: 'first_pop',
      title: 'First Pop',
      description: 'Sparge prima bulă',
      icon: Icons.bubble_chart,
      color: Color(0xFFFF4081),
      target: 1,
    ),
    Achievement(
      id: 'pop_50',
      title: 'Bubble Buster',
      description: 'Sparge 50 de bule total',
      icon: Icons.flare,
      color: Color(0xFF7C4DFF),
      target: 50,
    ),
    Achievement(
      id: 'pop_500',
      title: 'Pop Master',
      description: 'Sparge 500 de bule total',
      icon: Icons.auto_awesome,
      color: Color(0xFF40C4FF),
      target: 500,
    ),
    Achievement(
      id: 'pop_2000',
      title: 'Pop Legend',
      description: 'Sparge 2000 de bule total',
      icon: Icons.workspace_premium,
      color: Color(0xFFFFD740),
      target: 2000,
    ),
    Achievement(
      id: 'score_500',
      title: 'Score 500',
      description: 'Atinge scorul 500 într-o partidă',
      icon: Icons.trending_up,
      color: Color(0xFF69F0AE),
      target: 500,
    ),
    Achievement(
      id: 'score_2000',
      title: 'Score 2000',
      description: 'Atinge scorul 2000 într-o partidă',
      icon: Icons.rocket_launch,
      color: Color(0xFFFF6E40),
      target: 2000,
    ),
    Achievement(
      id: 'combo_5',
      title: 'Combo Streak',
      description: 'Sparge 5 bule în 2 secunde',
      icon: Icons.bolt,
      color: Color(0xFFFFCA28),
      target: 5,
    ),
    Achievement(
      id: 'games_25',
      title: 'Dedicated',
      description: 'Joacă 25 de partide',
      icon: Icons.emoji_events,
      color: Color(0xFFAB47BC),
      target: 25,
    ),
  ];

  Future<int> totalPopped() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_kTotalPoppedKey) ?? 0;
  }

  Future<int> bestScore() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_kBestScoreKey) ?? 0;
  }

  Future<int> bestCombo() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_kBestComboKey) ?? 0;
  }

  Future<int> gamesPlayed() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_kGamesPlayedKey) ?? 0;
  }

  Future<Set<String>> unlocked() async {
    final p = await SharedPreferences.getInstance();
    return (p.getStringList(_kUnlockedKey) ?? []).toSet();
  }

  Future<List<Achievement>> _checkUnlocks(Set<String> already) async {
    final tp = await totalPopped();
    final bs = await bestScore();
    final bc = await bestCombo();
    final gp = await gamesPlayed();
    final newly = <Achievement>[];
    for (final a in all) {
      if (already.contains(a.id)) continue;
      bool got = false;
      switch (a.id) {
        case 'first_pop':
          got = tp >= 1;
          break;
        case 'pop_50':
          got = tp >= 50;
          break;
        case 'pop_500':
          got = tp >= 500;
          break;
        case 'pop_2000':
          got = tp >= 2000;
          break;
        case 'score_500':
          got = bs >= 500;
          break;
        case 'score_2000':
          got = bs >= 2000;
          break;
        case 'combo_5':
          got = bc >= 5;
          break;
        case 'games_25':
          got = gp >= 25;
          break;
      }
      if (got) newly.add(a);
    }
    if (newly.isNotEmpty) {
      final p = await SharedPreferences.getInstance();
      already.addAll(newly.map((a) => a.id));
      await p.setStringList(_kUnlockedKey, already.toList());
    }
    return newly;
  }

  Future<List<Achievement>> recordPop({required int currentCombo}) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_kTotalPoppedKey, (await totalPopped()) + 1);
    if (currentCombo > await bestCombo()) {
      await p.setInt(_kBestComboKey, currentCombo);
    }
    return _checkUnlocks(await unlocked());
  }

  Future<List<Achievement>> recordGameEnd({required int score}) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_kGamesPlayedKey, (await gamesPlayed()) + 1);
    if (score > await bestScore()) {
      await p.setInt(_kBestScoreKey, score);
    }
    return _checkUnlocks(await unlocked());
  }

  Future<double> progressFor(Achievement a) async {
    int current = 0;
    final tp = await totalPopped();
    final bs = await bestScore();
    final bc = await bestCombo();
    final gp = await gamesPlayed();
    switch (a.id) {
      case 'first_pop':
      case 'pop_50':
      case 'pop_500':
      case 'pop_2000':
        current = tp;
        break;
      case 'score_500':
      case 'score_2000':
        current = bs;
        break;
      case 'combo_5':
        current = bc;
        break;
      case 'games_25':
        current = gp;
        break;
    }
    return (current / a.target).clamp(0.0, 1.0);
  }
}
