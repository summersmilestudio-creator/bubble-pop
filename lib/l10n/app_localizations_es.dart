// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get tooltipAchievements => 'Logros';

  @override
  String get tooltipShop => 'Tienda';

  @override
  String get topScore => 'MEJOR PUNTUACIÓN';

  @override
  String get newGame => 'JUGAR';

  @override
  String get adNotAvailable => 'No hay anuncios disponibles ahora.';

  @override
  String get gameOver => 'Fin del juego';

  @override
  String scoreResult(int score) {
    return 'Puntuación: $score';
  }

  @override
  String get newRecord => '🏆 ¡Récord!';

  @override
  String get lifeRegenHint =>
      'Las vidas se recargan solas, una cada 15 minutos.';

  @override
  String get playAgain => 'Jugar de nuevo';

  @override
  String get reviveWithAd => '+1 vida (anuncio)';

  @override
  String get achievementUnlocked => '🏆 Logro desbloqueado';

  @override
  String get statScore => 'PUNTOS';

  @override
  String get statTop => 'MEJOR';

  @override
  String get statLives => 'VIDAS';

  @override
  String get statLevel => 'NIVEL';

  @override
  String get refillLivesTooltip => '❤️ Recargar vidas (anuncio)';

  @override
  String get paused => '⏸  Pausa';

  @override
  String get start => 'EMPEZAR';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get sound => 'Sonido';

  @override
  String get soundSubtitle => 'Efectos de sonido del juego';

  @override
  String get vibration => 'Vibración';

  @override
  String get vibrationSubtitle => 'Respuesta háptica al tocar';

  @override
  String get version => 'Versión';

  @override
  String get publisher => 'Editor';

  @override
  String get shopUnavailableNow => 'La tienda no está disponible ahora.';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get shopTitle => 'Tienda';

  @override
  String get removeAds => 'Sin anuncios';

  @override
  String get removeAdsOwned => '¡Comprado! Disfruta del juego sin anuncios.';

  @override
  String get removeAdsDescription =>
      'Elimina los banners y los anuncios entre niveles para siempre.';

  @override
  String get unavailable => 'No disponible';

  @override
  String get coinPacks => 'PAQUETES DE MONEDAS';

  @override
  String get loading => 'Cargando...';

  @override
  String get shopUnavailable => 'Tienda no disponible';

  @override
  String coinsAmount(int count) {
    return '$count monedas';
  }

  @override
  String bonusAmount(int count) {
    return '+ $count EXTRA';
  }

  @override
  String get priceUnavailable => 'N/D';

  @override
  String get achievementsTitle => 'Logros';

  @override
  String get totalProgress => 'Progreso total';

  @override
  String achievementsProgress(int unlocked, int total) {
    return '$unlocked de $total logros';
  }

  @override
  String get achFirstPopTitle => 'Primer Pop';

  @override
  String get achFirstPopDesc => 'Revienta tu primera burbuja';

  @override
  String get achPop50Title => 'Revienta Burbujas';

  @override
  String get achPop50Desc => 'Revienta 50 burbujas en total';

  @override
  String get achPop500Title => 'Maestro del Pop';

  @override
  String get achPop500Desc => 'Revienta 500 burbujas en total';

  @override
  String get achPop2000Title => 'Leyenda del Pop';

  @override
  String get achPop2000Desc => 'Revienta 2000 burbujas en total';

  @override
  String get achScore500Title => 'Puntuación 500';

  @override
  String get achScore500Desc => 'Alcanza 500 puntos en una partida';

  @override
  String get achScore2000Title => 'Puntuación 2000';

  @override
  String get achScore2000Desc => 'Alcanza 2000 puntos en una partida';

  @override
  String get achCombo5Title => 'Racha Combo';

  @override
  String get achCombo5Desc => 'Revienta 5 burbujas en 2 segundos';

  @override
  String get achGames25Title => 'Dedicado';

  @override
  String get achGames25Desc => 'Juega 25 partidas';

  @override
  String get dailyBonus => 'BONO DIARIO';

  @override
  String dayOfSeven(int day) {
    return 'Día $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'D$day';
  }

  @override
  String get claim => 'RECLAMAR';

  @override
  String get offerRemoveAdsTitle => 'Quita los anuncios';

  @override
  String get offerRemoveAdsBody =>
      'Juega sin banners ni anuncios que te interrumpan. Una sola vez, para siempre.';

  @override
  String offerRemoveAdsButton(String price) {
    return 'Quitar anuncios • $price';
  }

  @override
  String get later => 'Más tarde';

  @override
  String get notificationTitle => 'Bubble Pop Saga';

  @override
  String get notificationBody => '¡Revienta unas burbujas y relájate! 🫧';

  @override
  String get livesFull => 'Vidas al máximo';

  @override
  String nextLifeIn(String time) {
    return 'Próxima vida en $time';
  }

  @override
  String get outOfLivesTitle => 'Sin vidas';

  @override
  String get outOfLivesBody =>
      'Espera a que se recarguen, mira un anuncio o usa monedas.';

  @override
  String get watchAdLife => '+1 vida (anuncio)';

  @override
  String coinsLife(int coins) {
    return '+1 vida ($coins 🪙)';
  }

  @override
  String get waitButton => 'Esperar';

  @override
  String get notEnoughCoins => 'No tienes monedas suficientes';

  @override
  String watchAdForCoins(int coins) {
    return 'Mira un anuncio → $coins monedas';
  }

  @override
  String coinsEarned(int coins) {
    return '¡+$coins monedas!';
  }

  @override
  String get powersTitle => 'PODERES';

  @override
  String get powerBombName => 'Bomba';

  @override
  String get powerBombDesc => 'Revienta todas las burbujas de la pantalla';

  @override
  String get powerFreezeName => 'Congelar';

  @override
  String get powerFreezeDesc => 'Detiene las burbujas 5 segundos';

  @override
  String get powerSlowName => 'Cámara lenta';

  @override
  String get powerSlowDesc =>
      'Las burbujas suben a media velocidad durante 10 segundos';

  @override
  String get powerShieldName => 'Escudo';

  @override
  String get powerShieldDesc =>
      'Bloquea un fallo: una burbuja perdida no te quita vida';

  @override
  String powerOwnedCount(int count) {
    return 'Tienes: $count';
  }

  @override
  String powerActivated(String name) {
    return '¡$name activado!';
  }

  @override
  String powerNoneLeft(String name) {
    return 'No te queda $name. Compra más en la tienda.';
  }

  @override
  String get shieldActive => '🛡 Escudo activo';

  @override
  String get buyAction => 'Comprar';
}
