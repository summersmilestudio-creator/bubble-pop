// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get tooltipAchievements => 'Obiettivi';

  @override
  String get tooltipShop => 'Negozio';

  @override
  String get topScore => 'PUNTEGGIO MIGLIORE';

  @override
  String get newGame => 'GIOCA';

  @override
  String get adNotAvailable => 'Nessuna pubblicità disponibile ora.';

  @override
  String get gameOver => 'Game Over';

  @override
  String scoreResult(int score) {
    return 'Punteggio: $score';
  }

  @override
  String get newRecord => '🏆 Record!';

  @override
  String get lifeRegenHint =>
      'Le vite si ricaricano da sole, una ogni 15 minuti.';

  @override
  String get playAgain => 'Nuova partita';

  @override
  String get reviveWithAd => '+1 vita (pubblicità)';

  @override
  String get achievementUnlocked => '🏆 Obiettivo sbloccato';

  @override
  String get statScore => 'PUNTI';

  @override
  String get statTop => 'MIGLIORE';

  @override
  String get statLives => 'VITE';

  @override
  String get statLevel => 'LIVELLO';

  @override
  String get refillLivesTooltip => '❤️ Ricarica vite (pubblicità)';

  @override
  String get paused => '⏸  Pausa';

  @override
  String get start => 'INIZIA';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get sound => 'Audio';

  @override
  String get soundSubtitle => 'Effetti sonori di gioco';

  @override
  String get vibration => 'Vibrazione';

  @override
  String get vibrationSubtitle => 'Feedback aptico al tocco';

  @override
  String get version => 'Versione';

  @override
  String get publisher => 'Editore';

  @override
  String get shopUnavailableNow => 'Il negozio non è disponibile ora.';

  @override
  String get restorePurchases => 'Ripristina acquisti';

  @override
  String get shopTitle => 'Negozio';

  @override
  String get removeAds => 'Senza pubblicità';

  @override
  String get removeAdsOwned => 'Acquistato — goditi il gioco senza pubblicità!';

  @override
  String get removeAdsDescription =>
      'Rimuovi i banner e le pubblicità tra i livelli per sempre.';

  @override
  String get unavailable => 'Non disponibile';

  @override
  String get coinPacks => 'PACCHETTI DI MONETE';

  @override
  String get loading => 'Caricamento...';

  @override
  String get shopUnavailable => 'Negozio non disponibile';

  @override
  String coinsAmount(int count) {
    return '$count monete';
  }

  @override
  String bonusAmount(int count) {
    return '+ $count BONUS';
  }

  @override
  String get priceUnavailable => 'N/D';

  @override
  String get achievementsTitle => 'Obiettivi';

  @override
  String get totalProgress => 'Progresso totale';

  @override
  String achievementsProgress(int unlocked, int total) {
    return '$unlocked di $total obiettivi';
  }

  @override
  String get achFirstPopTitle => 'Primo Scoppio';

  @override
  String get achFirstPopDesc => 'Fai scoppiare la tua prima bolla';

  @override
  String get achPop50Title => 'Scoppia-Bolle';

  @override
  String get achPop50Desc => 'Fai scoppiare 50 bolle in totale';

  @override
  String get achPop500Title => 'Maestro dello Scoppio';

  @override
  String get achPop500Desc => 'Fai scoppiare 500 bolle in totale';

  @override
  String get achPop2000Title => 'Leggenda dello Scoppio';

  @override
  String get achPop2000Desc => 'Fai scoppiare 2000 bolle in totale';

  @override
  String get achScore500Title => 'Punteggio 500';

  @override
  String get achScore500Desc => 'Raggiungi 500 punti in una partita';

  @override
  String get achScore2000Title => 'Punteggio 2000';

  @override
  String get achScore2000Desc => 'Raggiungi 2000 punti in una partita';

  @override
  String get achCombo5Title => 'Serie Combo';

  @override
  String get achCombo5Desc => 'Fai scoppiare 5 bolle in 2 secondi';

  @override
  String get achGames25Title => 'Appassionato';

  @override
  String get achGames25Desc => 'Gioca 25 partite';

  @override
  String get dailyBonus => 'BONUS GIORNALIERO';

  @override
  String dayOfSeven(int day) {
    return 'Giorno $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'G$day';
  }

  @override
  String get claim => 'RISCUOTI';

  @override
  String get offerRemoveAdsTitle => 'Via le pubblicità';

  @override
  String get offerRemoveAdsBody =>
      'Gioca senza banner e senza pubblicità che ti interrompono. Una volta sola, per sempre.';

  @override
  String offerRemoveAdsButton(String price) {
    return 'Rimuovi le pubblicità • $price';
  }

  @override
  String get later => 'Più tardi';

  @override
  String get notificationTitle => 'Bubble Pop Saga';

  @override
  String get notificationBody => 'Fai scoppiare qualche bolla e rilassati! 🫧';

  @override
  String get livesFull => 'Vite al massimo';

  @override
  String nextLifeIn(String time) {
    return 'Prossima vita tra $time';
  }

  @override
  String get outOfLivesTitle => 'Vite esaurite';

  @override
  String get outOfLivesBody =>
      'Aspetta che si ricarichino, guarda un annuncio o usa le monete.';

  @override
  String get watchAdLife => '+1 vita (annuncio)';

  @override
  String coinsLife(int coins) {
    return '+1 vita ($coins 🪙)';
  }

  @override
  String get waitButton => 'Aspetta';

  @override
  String get notEnoughCoins => 'Monete insufficienti';

  @override
  String watchAdForCoins(int coins) {
    return 'Guarda un annuncio → $coins monete';
  }

  @override
  String coinsEarned(int coins) {
    return '+$coins monete!';
  }

  @override
  String get powersTitle => 'POTERI';

  @override
  String get powerBombName => 'Bomba';

  @override
  String get powerBombDesc => 'Fa scoppiare tutte le bolle sullo schermo';

  @override
  String get powerFreezeName => 'Congela';

  @override
  String get powerFreezeDesc => 'Ferma le bolle per 5 secondi';

  @override
  String get powerSlowName => 'Rallentatore';

  @override
  String get powerSlowDesc => 'Le bolle salgono a metà velocità per 10 secondi';

  @override
  String get powerShieldName => 'Scudo';

  @override
  String get powerShieldDesc =>
      'Blocca un errore: una bolla persa non ti toglie una vita';

  @override
  String powerOwnedCount(int count) {
    return 'Ne hai: $count';
  }

  @override
  String powerActivated(String name) {
    return '$name attivato!';
  }

  @override
  String powerNoneLeft(String name) {
    return '$name esaurito. Comprane altri nel negozio.';
  }

  @override
  String get shieldActive => '🛡 Scudo attivo';

  @override
  String get buyAction => 'Acquista';
}
