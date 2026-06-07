// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get tooltipAchievements => 'Realizări';

  @override
  String get tooltipShop => 'Magazin';

  @override
  String get topScore => 'TOP SCORE';

  @override
  String get newGame => 'JOC NOU';

  @override
  String get adNotAvailable => 'Reclama nu e disponibilă acum.';

  @override
  String get gameOver => 'Game Over';

  @override
  String scoreResult(int score) {
    return 'Scor: $score';
  }

  @override
  String get newRecord => '🏆 Record!';

  @override
  String get lifeRegenHint =>
      'Viețile se refac singure, câte una la fiecare 15 minute.';

  @override
  String get playAgain => 'Joc nou';

  @override
  String get reviveWithAd => '+1 viață (reclamă)';

  @override
  String get achievementUnlocked => '🏆 Realizare deblocată';

  @override
  String get statScore => 'SCOR';

  @override
  String get statTop => 'TOP';

  @override
  String get statLives => 'VIEȚI';

  @override
  String get statLevel => 'NIVEL';

  @override
  String get refillLivesTooltip => '❤️ Refill vieți (reclamă)';

  @override
  String get paused => '⏸  Pauză';

  @override
  String get start => 'START';

  @override
  String get settingsTitle => 'Setări';

  @override
  String get sound => 'Sunet';

  @override
  String get soundSubtitle => 'Efecte sonore în joc';

  @override
  String get vibration => 'Vibrații';

  @override
  String get vibrationSubtitle => 'Haptic feedback la atingere';

  @override
  String get version => 'Versiune';

  @override
  String get publisher => 'Publisher';

  @override
  String get shopUnavailableNow => 'Magazinul nu este disponibil acum.';

  @override
  String get restorePurchases => 'Restaurează cumpărăturile';

  @override
  String get shopTitle => 'Magazin';

  @override
  String get removeAds => 'Fără reclame';

  @override
  String get removeAdsOwned => 'Achiziționat — bucură-te de joc fără reclame!';

  @override
  String get removeAdsDescription =>
      'Elimină banner-ele și reclamele între nivele permanent.';

  @override
  String get unavailable => 'Indisponibil';

  @override
  String get coinPacks => 'PACHETE MONEDE';

  @override
  String get loading => 'Se încarcă...';

  @override
  String get shopUnavailable => 'Magazin indisponibil';

  @override
  String coinsAmount(int count) {
    return '$count monede';
  }

  @override
  String bonusAmount(int count) {
    return '+ $count BONUS';
  }

  @override
  String get priceUnavailable => 'N/A';

  @override
  String get achievementsTitle => 'Realizări';

  @override
  String get totalProgress => 'Progres total';

  @override
  String achievementsProgress(int unlocked, int total) {
    return '$unlocked din $total realizări';
  }

  @override
  String get achFirstPopTitle => 'Prima Bulă';

  @override
  String get achFirstPopDesc => 'Sparge prima bulă';

  @override
  String get achPop50Title => 'Spărgător de Bule';

  @override
  String get achPop50Desc => 'Sparge 50 de bule total';

  @override
  String get achPop500Title => 'Maestru al Bulelor';

  @override
  String get achPop500Desc => 'Sparge 500 de bule total';

  @override
  String get achPop2000Title => 'Legendă a Bulelor';

  @override
  String get achPop2000Desc => 'Sparge 2000 de bule total';

  @override
  String get achScore500Title => 'Scor 500';

  @override
  String get achScore500Desc => 'Atinge scorul 500 într-o partidă';

  @override
  String get achScore2000Title => 'Scor 2000';

  @override
  String get achScore2000Desc => 'Atinge scorul 2000 într-o partidă';

  @override
  String get achCombo5Title => 'Serie Combo';

  @override
  String get achCombo5Desc => 'Sparge 5 bule în 2 secunde';

  @override
  String get achGames25Title => 'Dedicat';

  @override
  String get achGames25Desc => 'Joacă 25 de partide';

  @override
  String get dailyBonus => 'BONUS ZILNIC';

  @override
  String dayOfSeven(int day) {
    return 'Ziua $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'Z$day';
  }

  @override
  String get claim => 'PRIMEȘTE';

  @override
  String get offerRemoveAdsTitle => 'Scapă de reclame';

  @override
  String get offerRemoveAdsBody =>
      'Joacă fără bannere și fără reclame care te întrerup. O singură dată, pentru totdeauna.';

  @override
  String offerRemoveAdsButton(String price) {
    return 'Elimină reclamele • $price';
  }

  @override
  String get later => 'Mai târziu';

  @override
  String get notificationTitle => 'Bubble Pop Saga';

  @override
  String get notificationBody => 'Sparge niște bule și relaxează-te! 🫧';

  @override
  String get livesFull => 'Vieți pline';

  @override
  String nextLifeIn(String time) {
    return 'Următoarea viață în $time';
  }

  @override
  String get outOfLivesTitle => 'Nu mai ai vieți';

  @override
  String get outOfLivesBody =>
      'Așteaptă refacerea lor, vezi o reclamă sau folosește monede.';

  @override
  String get watchAdLife => '+1 viață (reclamă)';

  @override
  String coinsLife(int coins) {
    return '+1 viață ($coins 🪙)';
  }

  @override
  String get waitButton => 'Aștept';

  @override
  String get notEnoughCoins => 'Nu ai destule monede';

  @override
  String watchAdForCoins(int coins) {
    return 'Vezi o reclamă → $coins monede';
  }

  @override
  String coinsEarned(int coins) {
    return '+$coins monede!';
  }

  @override
  String get powersTitle => 'PUTERI';

  @override
  String get powerBombName => 'Bombă';

  @override
  String get powerBombDesc => 'Sparge toate baloanele de pe ecran';

  @override
  String get powerFreezeName => 'Înghețare';

  @override
  String get powerFreezeDesc => 'Oprește baloanele 5 secunde';

  @override
  String get powerSlowName => 'Încetinitor';

  @override
  String get powerSlowDesc => 'Baloanele urcă cu jumătate de viteză 10 secunde';

  @override
  String get powerShieldName => 'Scut';

  @override
  String get powerShieldDesc =>
      'Blochează o ratare — un balon scăpat nu îți ia viață';

  @override
  String powerOwnedCount(int count) {
    return 'Ai: $count';
  }

  @override
  String powerActivated(String name) {
    return '$name activat!';
  }

  @override
  String powerNoneLeft(String name) {
    return 'Nu mai ai $name. Cumpără din magazin.';
  }

  @override
  String get shieldActive => '🛡 Scut activ';

  @override
  String get buyAction => 'Cumpără';

  @override
  String get language => 'Limbă';

  @override
  String get languageSystem => 'Implicit (sistem)';
}
