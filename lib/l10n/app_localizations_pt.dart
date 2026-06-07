// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get tooltipAchievements => 'Conquistas';

  @override
  String get tooltipShop => 'Loja';

  @override
  String get topScore => 'MELHOR PONTUAÇÃO';

  @override
  String get newGame => 'JOGAR';

  @override
  String get adNotAvailable => 'Nenhum anúncio disponível agora.';

  @override
  String get gameOver => 'Fim de jogo';

  @override
  String scoreResult(int score) {
    return 'Pontuação: $score';
  }

  @override
  String get newRecord => '🏆 Recorde!';

  @override
  String get lifeRegenHint =>
      'As vidas recarregam sozinhas, uma a cada 15 minutos.';

  @override
  String get playAgain => 'Jogar de novo';

  @override
  String get reviveWithAd => '+1 vida (anúncio)';

  @override
  String get achievementUnlocked => '🏆 Conquista desbloqueada';

  @override
  String get statScore => 'PONTOS';

  @override
  String get statTop => 'RECORDE';

  @override
  String get statLives => 'VIDAS';

  @override
  String get statLevel => 'NÍVEL';

  @override
  String get refillLivesTooltip => '❤️ Repor vidas (anúncio)';

  @override
  String get paused => '⏸  Pausado';

  @override
  String get start => 'INICIAR';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get sound => 'Som';

  @override
  String get soundSubtitle => 'Efeitos sonoros do jogo';

  @override
  String get vibration => 'Vibração';

  @override
  String get vibrationSubtitle => 'Resposta tátil ao tocar';

  @override
  String get version => 'Versão';

  @override
  String get publisher => 'Publicadora';

  @override
  String get shopUnavailableNow => 'A loja não está disponível agora.';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get shopTitle => 'Loja';

  @override
  String get removeAds => 'Sem anúncios';

  @override
  String get removeAdsOwned => 'Comprado — aproveite o jogo sem anúncios!';

  @override
  String get removeAdsDescription =>
      'Remova os banners e os anúncios entre níveis para sempre.';

  @override
  String get unavailable => 'Indisponível';

  @override
  String get coinPacks => 'PACOTES DE MOEDAS';

  @override
  String get loading => 'Carregando...';

  @override
  String get shopUnavailable => 'Loja indisponível';

  @override
  String coinsAmount(int count) {
    return '$count moedas';
  }

  @override
  String bonusAmount(int count) {
    return '+ $count BÔNUS';
  }

  @override
  String get priceUnavailable => 'N/D';

  @override
  String get achievementsTitle => 'Conquistas';

  @override
  String get totalProgress => 'Progresso total';

  @override
  String achievementsProgress(int unlocked, int total) {
    return '$unlocked de $total conquistas';
  }

  @override
  String get achFirstPopTitle => 'Primeiro Estouro';

  @override
  String get achFirstPopDesc => 'Estoure sua primeira bolha';

  @override
  String get achPop50Title => 'Estoura-Bolhas';

  @override
  String get achPop50Desc => 'Estoure 50 bolhas no total';

  @override
  String get achPop500Title => 'Mestre do Estouro';

  @override
  String get achPop500Desc => 'Estoure 500 bolhas no total';

  @override
  String get achPop2000Title => 'Lenda do Estouro';

  @override
  String get achPop2000Desc => 'Estoure 2000 bolhas no total';

  @override
  String get achScore500Title => 'Pontuação 500';

  @override
  String get achScore500Desc => 'Alcance 500 pontos em uma partida';

  @override
  String get achScore2000Title => 'Pontuação 2000';

  @override
  String get achScore2000Desc => 'Alcance 2000 pontos em uma partida';

  @override
  String get achCombo5Title => 'Sequência Combo';

  @override
  String get achCombo5Desc => 'Estoure 5 bolhas em 2 segundos';

  @override
  String get achGames25Title => 'Dedicado';

  @override
  String get achGames25Desc => 'Jogue 25 partidas';

  @override
  String get dailyBonus => 'BÔNUS DIÁRIO';

  @override
  String dayOfSeven(int day) {
    return 'Dia $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'D$day';
  }

  @override
  String get claim => 'RESGATAR';

  @override
  String get offerRemoveAdsTitle => 'Acabe com os anúncios';

  @override
  String get offerRemoveAdsBody =>
      'Jogue sem banners e sem anúncios que interrompem. Uma só vez, para sempre.';

  @override
  String offerRemoveAdsButton(String price) {
    return 'Remover anúncios • $price';
  }

  @override
  String get later => 'Mais tarde';

  @override
  String get notificationTitle => 'Bubble Pop Saga';

  @override
  String get notificationBody => 'Estoure umas bolhas e relaxe! 🫧';

  @override
  String get livesFull => 'Vidas no máximo';

  @override
  String nextLifeIn(String time) {
    return 'Próxima vida em $time';
  }

  @override
  String get outOfLivesTitle => 'Sem vidas';

  @override
  String get outOfLivesBody =>
      'Espera recarregarem, vê um anúncio ou usa moedas.';

  @override
  String get watchAdLife => '+1 vida (anúncio)';

  @override
  String coinsLife(int coins) {
    return '+1 vida ($coins 🪙)';
  }

  @override
  String get waitButton => 'Esperar';

  @override
  String get notEnoughCoins => 'Moedas insuficientes';

  @override
  String watchAdForCoins(int coins) {
    return 'Vê um anúncio → $coins moedas';
  }

  @override
  String coinsEarned(int coins) {
    return '+$coins moedas!';
  }

  @override
  String get powersTitle => 'PODERES';

  @override
  String get powerBombName => 'Bomba';

  @override
  String get powerBombDesc => 'Estoura todas as bolhas do ecrã';

  @override
  String get powerFreezeName => 'Congelar';

  @override
  String get powerFreezeDesc => 'Para as bolhas por 5 segundos';

  @override
  String get powerSlowName => 'Câmara lenta';

  @override
  String get powerSlowDesc =>
      'As bolhas sobem a meia velocidade por 10 segundos';

  @override
  String get powerShieldName => 'Escudo';

  @override
  String get powerShieldDesc =>
      'Bloqueia uma falha: uma bolha perdida não tira vida';

  @override
  String powerOwnedCount(int count) {
    return 'Tens: $count';
  }

  @override
  String powerActivated(String name) {
    return '$name ativado!';
  }

  @override
  String powerNoneLeft(String name) {
    return 'Sem $name. Compra mais na loja.';
  }

  @override
  String get shieldActive => '🛡 Escudo ativo';

  @override
  String get buyAction => 'Comprar';
}
