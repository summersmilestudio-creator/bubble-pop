// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get tooltipAchievements => 'Достижения';

  @override
  String get tooltipShop => 'Магазин';

  @override
  String get topScore => 'ЛУЧШИЙ СЧЁТ';

  @override
  String get newGame => 'ИГРАТЬ';

  @override
  String get adNotAvailable => 'Реклама сейчас недоступна.';

  @override
  String get gameOver => 'Игра окончена';

  @override
  String scoreResult(int score) {
    return 'Счёт: $score';
  }

  @override
  String get newRecord => '🏆 Рекорд!';

  @override
  String get lifeRegenHint =>
      'Во время игры одна жизнь восстанавливается каждые 3 минуты.';

  @override
  String get playAgain => 'Новая игра';

  @override
  String get reviveWithAd => '+1 жизнь (реклама)';

  @override
  String get achievementUnlocked => '🏆 Достижение открыто';

  @override
  String get statScore => 'СЧЁТ';

  @override
  String get statTop => 'РЕКОРД';

  @override
  String get statLives => 'ЖИЗНИ';

  @override
  String get statLevel => 'УРОВЕНЬ';

  @override
  String get refillLivesTooltip => '❤️ Восполнить жизни (реклама)';

  @override
  String get paused => '⏸  Пауза';

  @override
  String get start => 'СТАРТ';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get sound => 'Звук';

  @override
  String get soundSubtitle => 'Звуковые эффекты в игре';

  @override
  String get vibration => 'Вибрация';

  @override
  String get vibrationSubtitle => 'Тактильный отклик при касании';

  @override
  String get version => 'Версия';

  @override
  String get publisher => 'Издатель';

  @override
  String get shopUnavailableNow => 'Магазин сейчас недоступен.';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get shopTitle => 'Магазин';

  @override
  String get removeAds => 'Без рекламы';

  @override
  String get removeAdsOwned => 'Куплено — наслаждайтесь игрой без рекламы!';

  @override
  String get removeAdsDescription =>
      'Уберите баннеры и рекламу между уровнями навсегда.';

  @override
  String get unavailable => 'Недоступно';

  @override
  String get coinPacks => 'НАБОРЫ МОНЕТ';

  @override
  String get loading => 'Загрузка...';

  @override
  String get shopUnavailable => 'Магазин недоступен';

  @override
  String coinsAmount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count монеты',
      many: '$count монет',
      few: '$count монеты',
      one: '$count монета',
    );
    return '$_temp0';
  }

  @override
  String bonusAmount(int count) {
    return '+ $count БОНУС';
  }

  @override
  String get priceUnavailable => 'Н/Д';

  @override
  String get achievementsTitle => 'Достижения';

  @override
  String get totalProgress => 'Общий прогресс';

  @override
  String achievementsProgress(int unlocked, int total) {
    return '$unlocked из $total достижений';
  }

  @override
  String get achFirstPopTitle => 'Первый лопок';

  @override
  String get achFirstPopDesc => 'Лопни первый пузырь';

  @override
  String get achPop50Title => 'Гроза пузырей';

  @override
  String get achPop50Desc => 'Лопни 50 пузырей всего';

  @override
  String get achPop500Title => 'Мастер лопанья';

  @override
  String get achPop500Desc => 'Лопни 500 пузырей всего';

  @override
  String get achPop2000Title => 'Легенда лопанья';

  @override
  String get achPop2000Desc => 'Лопни 2000 пузырей всего';

  @override
  String get achScore500Title => 'Счёт 500';

  @override
  String get achScore500Desc => 'Набери 500 очков за одну игру';

  @override
  String get achScore2000Title => 'Счёт 2000';

  @override
  String get achScore2000Desc => 'Набери 2000 очков за одну игру';

  @override
  String get achCombo5Title => 'Серия комбо';

  @override
  String get achCombo5Desc => 'Лопни 5 пузырей за 2 секунды';

  @override
  String get achGames25Title => 'Преданный игрок';

  @override
  String get achGames25Desc => 'Сыграй 25 игр';

  @override
  String get dailyBonus => 'ЕЖЕДНЕВНЫЙ БОНУС';

  @override
  String dayOfSeven(int day) {
    return 'День $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'Д$day';
  }

  @override
  String get claim => 'ЗАБРАТЬ';

  @override
  String get offerRemoveAdsTitle => 'Избавьтесь от рекламы';

  @override
  String get offerRemoveAdsBody =>
      'Играйте без баннеров и рекламы, которая мешает. Один раз и навсегда.';

  @override
  String offerRemoveAdsButton(String price) {
    return 'Убрать рекламу • $price';
  }

  @override
  String get later => 'Позже';

  @override
  String get notificationTitle => 'Bubble Pop Saga';

  @override
  String get notificationBody => 'Лопни пару пузырей и отдохни! 🫧';
}
