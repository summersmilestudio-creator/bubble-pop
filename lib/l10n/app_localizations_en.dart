// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tooltipAchievements => 'Achievements';

  @override
  String get tooltipShop => 'Shop';

  @override
  String get topScore => 'TOP SCORE';

  @override
  String get newGame => 'NEW GAME';

  @override
  String get adNotAvailable => 'No ad available right now.';

  @override
  String get gameOver => 'Game Over';

  @override
  String scoreResult(int score) {
    return 'Score: $score';
  }

  @override
  String get newRecord => '🏆 New record!';

  @override
  String get lifeRegenHint =>
      'You get one life back every 3 minutes while playing.';

  @override
  String get playAgain => 'New game';

  @override
  String get reviveWithAd => '+1 life (ad)';

  @override
  String get achievementUnlocked => '🏆 Achievement unlocked';

  @override
  String get statScore => 'SCORE';

  @override
  String get statTop => 'BEST';

  @override
  String get statLives => 'LIVES';

  @override
  String get statLevel => 'LEVEL';

  @override
  String get refillLivesTooltip => '❤️ Refill lives (ad)';

  @override
  String get paused => '⏸  Paused';

  @override
  String get start => 'START';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get sound => 'Sound';

  @override
  String get soundSubtitle => 'In-game sound effects';

  @override
  String get vibration => 'Vibration';

  @override
  String get vibrationSubtitle => 'Haptic feedback on tap';

  @override
  String get version => 'Version';

  @override
  String get publisher => 'Publisher';

  @override
  String get shopUnavailableNow => 'The store isn\'t available right now.';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get shopTitle => 'Shop';

  @override
  String get removeAds => 'Remove ads';

  @override
  String get removeAdsOwned => 'Purchased — enjoy the game ad-free!';

  @override
  String get removeAdsDescription =>
      'Remove banners and between-level ads forever.';

  @override
  String get unavailable => 'Unavailable';

  @override
  String get coinPacks => 'COIN PACKS';

  @override
  String get loading => 'Loading...';

  @override
  String get shopUnavailable => 'Store unavailable';

  @override
  String coinsAmount(int count) {
    return '$count coins';
  }

  @override
  String bonusAmount(int count) {
    return '+ $count BONUS';
  }

  @override
  String get priceUnavailable => 'N/A';

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String get totalProgress => 'Total progress';

  @override
  String achievementsProgress(int unlocked, int total) {
    return '$unlocked of $total achievements';
  }

  @override
  String get achFirstPopTitle => 'First Pop';

  @override
  String get achFirstPopDesc => 'Pop your first bubble';

  @override
  String get achPop50Title => 'Bubble Buster';

  @override
  String get achPop50Desc => 'Pop 50 bubbles total';

  @override
  String get achPop500Title => 'Pop Master';

  @override
  String get achPop500Desc => 'Pop 500 bubbles total';

  @override
  String get achPop2000Title => 'Pop Legend';

  @override
  String get achPop2000Desc => 'Pop 2000 bubbles total';

  @override
  String get achScore500Title => 'Score 500';

  @override
  String get achScore500Desc => 'Reach a score of 500 in one game';

  @override
  String get achScore2000Title => 'Score 2000';

  @override
  String get achScore2000Desc => 'Reach a score of 2000 in one game';

  @override
  String get achCombo5Title => 'Combo Streak';

  @override
  String get achCombo5Desc => 'Pop 5 bubbles within 2 seconds';

  @override
  String get achGames25Title => 'Dedicated';

  @override
  String get achGames25Desc => 'Play 25 games';

  @override
  String get dailyBonus => 'DAILY BONUS';

  @override
  String dayOfSeven(int day) {
    return 'Day $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'D$day';
  }

  @override
  String get claim => 'CLAIM';

  @override
  String get offerRemoveAdsTitle => 'Get rid of ads';

  @override
  String get offerRemoveAdsBody =>
      'Play with no banners and no interrupting ads. One time, forever.';

  @override
  String offerRemoveAdsButton(String price) {
    return 'Remove ads • $price';
  }

  @override
  String get later => 'Later';

  @override
  String get notificationTitle => 'Bubble Pop Saga';

  @override
  String get notificationBody => 'Pop some bubbles and unwind! 🫧';
}
