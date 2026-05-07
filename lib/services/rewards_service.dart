import 'package:shared_preferences/shared_preferences.dart';

class RewardsService {
  static const _kCoinsKey = 'bpCoins';
  static const _kLastLoginKey = 'bpLastLogin';
  static const _kStreakKey = 'bpStreak';
  static const dailyRewards = [10, 15, 25, 40, 60, 90, 150];

  Future<int> getCoins() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_kCoinsKey) ?? 50;
  }

  Future<void> addCoins(int n) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_kCoinsKey, await getCoins() + n);
  }

  Future<({int day, int reward})> claimDailyIfAvailable() async {
    final p = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastEpoch = p.getInt(_kLastLoginKey);
    final streak = p.getInt(_kStreakKey) ?? 0;
    if (lastEpoch != null) {
      final last = DateTime.fromMillisecondsSinceEpoch(lastEpoch);
      final lastDay = DateTime(last.year, last.month, last.day);
      if (lastDay.isAtSameMomentAs(today)) return (day: streak, reward: 0);
      final diff = today.difference(lastDay).inDays;
      final newStreak = (diff == 1 ? streak + 1 : 1).clamp(1, 7);
      final reward = dailyRewards[newStreak - 1];
      await addCoins(reward);
      await p.setInt(_kLastLoginKey, today.millisecondsSinceEpoch);
      await p.setInt(_kStreakKey, newStreak);
      return (day: newStreak, reward: reward);
    }
    final reward = dailyRewards[0];
    await addCoins(reward);
    await p.setInt(_kLastLoginKey, today.millisecondsSinceEpoch);
    await p.setInt(_kStreakKey, 1);
    return (day: 1, reward: reward);
  }
}

class SettingsService {
  static const _kSound = 'soundOn';
  static const _kHaptic = 'hapticOn';

  Future<bool> soundOn() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_kSound) ?? true;
  }

  Future<void> setSound(bool v) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kSound, v);
  }

  Future<bool> hapticOn() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_kHaptic) ?? true;
  }

  Future<void> setHaptic(bool v) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kHaptic, v);
  }
}
