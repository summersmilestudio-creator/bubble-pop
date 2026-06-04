// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get tooltipAchievements => 'Erfolge';

  @override
  String get tooltipShop => 'Shop';

  @override
  String get topScore => 'BESTE PUNKTZAHL';

  @override
  String get newGame => 'SPIELEN';

  @override
  String get adNotAvailable => 'Gerade keine Werbung verfügbar.';

  @override
  String get gameOver => 'Spiel vorbei';

  @override
  String scoreResult(int score) {
    return 'Punkte: $score';
  }

  @override
  String get newRecord => '🏆 Rekord!';

  @override
  String get lifeRegenHint =>
      'Während des Spiels bekommst du alle 3 Minuten ein Leben zurück.';

  @override
  String get playAgain => 'Neues Spiel';

  @override
  String get reviveWithAd => '+1 Leben (Werbung)';

  @override
  String get achievementUnlocked => '🏆 Erfolg freigeschaltet';

  @override
  String get statScore => 'PUNKTE';

  @override
  String get statTop => 'BEST';

  @override
  String get statLives => 'LEBEN';

  @override
  String get statLevel => 'LEVEL';

  @override
  String get refillLivesTooltip => '❤️ Leben auffüllen (Werbung)';

  @override
  String get paused => '⏸  Pause';

  @override
  String get start => 'START';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get sound => 'Ton';

  @override
  String get soundSubtitle => 'Soundeffekte im Spiel';

  @override
  String get vibration => 'Vibration';

  @override
  String get vibrationSubtitle => 'Haptisches Feedback beim Tippen';

  @override
  String get version => 'Version';

  @override
  String get publisher => 'Herausgeber';

  @override
  String get shopUnavailableNow => 'Der Shop ist gerade nicht verfügbar.';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get shopTitle => 'Shop';

  @override
  String get removeAds => 'Werbefrei';

  @override
  String get removeAdsOwned => 'Gekauft — genieße das Spiel ohne Werbung!';

  @override
  String get removeAdsDescription =>
      'Entferne Banner und Werbung zwischen den Levels für immer.';

  @override
  String get unavailable => 'Nicht verfügbar';

  @override
  String get coinPacks => 'MÜNZPAKETE';

  @override
  String get loading => 'Wird geladen...';

  @override
  String get shopUnavailable => 'Shop nicht verfügbar';

  @override
  String coinsAmount(int count) {
    return '$count Münzen';
  }

  @override
  String bonusAmount(int count) {
    return '+ $count BONUS';
  }

  @override
  String get priceUnavailable => 'N/V';

  @override
  String get achievementsTitle => 'Erfolge';

  @override
  String get totalProgress => 'Gesamtfortschritt';

  @override
  String achievementsProgress(int unlocked, int total) {
    return '$unlocked von $total Erfolgen';
  }

  @override
  String get achFirstPopTitle => 'Erster Knaller';

  @override
  String get achFirstPopDesc => 'Zerplatze deine erste Blase';

  @override
  String get achPop50Title => 'Blasenknacker';

  @override
  String get achPop50Desc => 'Zerplatze insgesamt 50 Blasen';

  @override
  String get achPop500Title => 'Pop-Meister';

  @override
  String get achPop500Desc => 'Zerplatze insgesamt 500 Blasen';

  @override
  String get achPop2000Title => 'Pop-Legende';

  @override
  String get achPop2000Desc => 'Zerplatze insgesamt 2000 Blasen';

  @override
  String get achScore500Title => 'Punkte 500';

  @override
  String get achScore500Desc => 'Erreiche in einer Runde 500 Punkte';

  @override
  String get achScore2000Title => 'Punkte 2000';

  @override
  String get achScore2000Desc => 'Erreiche in einer Runde 2000 Punkte';

  @override
  String get achCombo5Title => 'Combo-Serie';

  @override
  String get achCombo5Desc => 'Zerplatze 5 Blasen in 2 Sekunden';

  @override
  String get achGames25Title => 'Mit Leidenschaft';

  @override
  String get achGames25Desc => 'Spiele 25 Runden';

  @override
  String get dailyBonus => 'TÄGLICHER BONUS';

  @override
  String dayOfSeven(int day) {
    return 'Tag $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'T$day';
  }

  @override
  String get claim => 'ABHOLEN';

  @override
  String get offerRemoveAdsTitle => 'Schluss mit Werbung';

  @override
  String get offerRemoveAdsBody =>
      'Spiele ohne Banner und ohne störende Werbung. Einmalig, für immer.';

  @override
  String offerRemoveAdsButton(String price) {
    return 'Werbung entfernen • $price';
  }

  @override
  String get later => 'Später';

  @override
  String get notificationTitle => 'Bubble Pop Saga';

  @override
  String get notificationBody =>
      'Zerplatze ein paar Blasen und entspann dich! 🫧';
}
