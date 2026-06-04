// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get tooltipAchievements => 'Succès';

  @override
  String get tooltipShop => 'Boutique';

  @override
  String get topScore => 'MEILLEUR SCORE';

  @override
  String get newGame => 'JOUER';

  @override
  String get adNotAvailable => 'Aucune pub disponible pour le moment.';

  @override
  String get gameOver => 'Partie terminée';

  @override
  String scoreResult(int score) {
    return 'Score : $score';
  }

  @override
  String get newRecord => '🏆 Record !';

  @override
  String get lifeRegenHint =>
      'Tu récupères une vie toutes les 3 minutes pendant la partie.';

  @override
  String get playAgain => 'Rejouer';

  @override
  String get reviveWithAd => '+1 vie (pub)';

  @override
  String get achievementUnlocked => '🏆 Succès débloqué';

  @override
  String get statScore => 'SCORE';

  @override
  String get statTop => 'RECORD';

  @override
  String get statLives => 'VIES';

  @override
  String get statLevel => 'NIVEAU';

  @override
  String get refillLivesTooltip => '❤️ Recharger les vies (pub)';

  @override
  String get paused => '⏸  Pause';

  @override
  String get start => 'DÉMARRER';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get sound => 'Son';

  @override
  String get soundSubtitle => 'Effets sonores du jeu';

  @override
  String get vibration => 'Vibrations';

  @override
  String get vibrationSubtitle => 'Retour haptique au toucher';

  @override
  String get version => 'Version';

  @override
  String get publisher => 'Éditeur';

  @override
  String get shopUnavailableNow =>
      'La boutique n\'est pas disponible pour le moment.';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get shopTitle => 'Boutique';

  @override
  String get removeAds => 'Sans pub';

  @override
  String get removeAdsOwned => 'Acheté — profite du jeu sans pub !';

  @override
  String get removeAdsDescription =>
      'Supprime les bannières et les pubs entre les niveaux pour toujours.';

  @override
  String get unavailable => 'Indisponible';

  @override
  String get coinPacks => 'PACKS DE PIÈCES';

  @override
  String get loading => 'Chargement...';

  @override
  String get shopUnavailable => 'Boutique indisponible';

  @override
  String coinsAmount(int count) {
    return '$count pièces';
  }

  @override
  String bonusAmount(int count) {
    return '+ $count BONUS';
  }

  @override
  String get priceUnavailable => 'N/D';

  @override
  String get achievementsTitle => 'Succès';

  @override
  String get totalProgress => 'Progression totale';

  @override
  String achievementsProgress(int unlocked, int total) {
    return '$unlocked succès sur $total';
  }

  @override
  String get achFirstPopTitle => 'Premier Éclat';

  @override
  String get achFirstPopDesc => 'Éclate ta première bulle';

  @override
  String get achPop50Title => 'Crève-Bulles';

  @override
  String get achPop50Desc => 'Éclate 50 bulles au total';

  @override
  String get achPop500Title => 'Maître de l\'Éclat';

  @override
  String get achPop500Desc => 'Éclate 500 bulles au total';

  @override
  String get achPop2000Title => 'Légende de l\'Éclat';

  @override
  String get achPop2000Desc => 'Éclate 2000 bulles au total';

  @override
  String get achScore500Title => 'Score 500';

  @override
  String get achScore500Desc => 'Atteins 500 points en une partie';

  @override
  String get achScore2000Title => 'Score 2000';

  @override
  String get achScore2000Desc => 'Atteins 2000 points en une partie';

  @override
  String get achCombo5Title => 'Série Combo';

  @override
  String get achCombo5Desc => 'Éclate 5 bulles en 2 secondes';

  @override
  String get achGames25Title => 'Mordu';

  @override
  String get achGames25Desc => 'Joue 25 parties';

  @override
  String get dailyBonus => 'BONUS QUOTIDIEN';

  @override
  String dayOfSeven(int day) {
    return 'Jour $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'J$day';
  }

  @override
  String get claim => 'RÉCUPÉRER';

  @override
  String get offerRemoveAdsTitle => 'Fini les pubs';

  @override
  String get offerRemoveAdsBody =>
      'Joue sans bannières ni pubs qui t\'interrompent. Une seule fois, pour toujours.';

  @override
  String offerRemoveAdsButton(String price) {
    return 'Supprimer les pubs • $price';
  }

  @override
  String get later => 'Plus tard';

  @override
  String get notificationTitle => 'Bubble Pop Saga';

  @override
  String get notificationBody => 'Éclate quelques bulles et détends-toi ! 🫧';
}
