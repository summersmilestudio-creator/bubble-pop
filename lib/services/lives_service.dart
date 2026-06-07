import 'package:shared_preferences/shared_preferences.dart';

/// Persistent energy / lives system.
///
/// The player has up to [maxLives] lives. Starting a game consumes one life.
/// One life regenerates every [regenInterval] of REAL time (even while the app
/// is closed), tracked via a stored anchor timestamp so the count survives
/// restarts. When full, lives stop regenerating and the anchor is parked at
/// "now" so the next spend starts a fresh window.
class LivesService {
  LivesService._();
  static final instance = LivesService._();

  static const int maxLives = 5;
  static const Duration regenInterval = Duration(minutes: 15);

  /// Coins it costs to instantly refill one life.
  static const int lifeCoinCost = 30;

  static const _kLives = 'bpLives';
  static const _kAnchor = 'bpLivesAnchor'; // ms epoch: start of current regen window

  int _nowMs() => DateTime.now().millisecondsSinceEpoch;

  /// Current number of lives, applying any regeneration accrued since the last
  /// read and persisting the result.
  Future<int> getLives() async {
    final p = await SharedPreferences.getInstance();
    int lives = p.getInt(_kLives) ?? maxLives;

    if (lives >= maxLives) {
      await p.setInt(_kLives, maxLives);
      await p.setInt(_kAnchor, _nowMs());
      return maxLives;
    }

    final anchor = p.getInt(_kAnchor) ?? _nowMs();
    final regenMs = regenInterval.inMilliseconds;
    final elapsed = _nowMs() - anchor;

    if (elapsed >= regenMs) {
      final gained = elapsed ~/ regenMs;
      lives = (lives + gained).clamp(0, maxLives);
      if (lives >= maxLives) {
        await p.setInt(_kAnchor, _nowMs());
      } else {
        // Carry over the leftover time into the next window.
        await p.setInt(_kAnchor, anchor + gained * regenMs);
      }
      await p.setInt(_kLives, lives);
    }
    return lives;
  }

  /// Milliseconds until the next life regenerates; 0 when already full.
  Future<int> millisToNextLife() async {
    final lives = await getLives();
    if (lives >= maxLives) return 0;
    final p = await SharedPreferences.getInstance();
    final anchor = p.getInt(_kAnchor) ?? _nowMs();
    final regenMs = regenInterval.inMilliseconds;
    final elapsed = _nowMs() - anchor;
    final remaining = regenMs - (elapsed % regenMs);
    return remaining.clamp(0, regenMs);
  }

  /// Tries to consume one life to start a game. Returns false if none left.
  Future<bool> consume() async {
    final lives = await getLives();
    if (lives <= 0) return false;
    final p = await SharedPreferences.getInstance();
    final wasFull = lives >= maxLives;
    await p.setInt(_kLives, lives - 1);
    // Leaving "full" starts the regen clock from now.
    if (wasFull) await p.setInt(_kAnchor, _nowMs());
    return true;
  }

  /// Adds [n] lives (capped at [maxLives]); used by rewarded ad / coins refill.
  Future<int> add(int n) async {
    final lives = await getLives();
    final p = await SharedPreferences.getInstance();
    final newLives = (lives + n).clamp(0, maxLives);
    await p.setInt(_kLives, newLives);
    if (newLives >= maxLives) await p.setInt(_kAnchor, _nowMs());
    return newLives;
  }
}
