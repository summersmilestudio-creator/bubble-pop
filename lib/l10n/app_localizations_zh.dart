// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get tooltipAchievements => '成就';

  @override
  String get tooltipShop => '商店';

  @override
  String get topScore => '最高分';

  @override
  String get newGame => '开始游戏';

  @override
  String get adNotAvailable => '暂时没有可用的广告。';

  @override
  String get gameOver => '游戏结束';

  @override
  String scoreResult(int score) {
    return '得分：$score';
  }

  @override
  String get newRecord => '🏆 新纪录！';

  @override
  String get lifeRegenHint => '游戏时每 3 分钟恢复一条生命。';

  @override
  String get playAgain => '再玩一局';

  @override
  String get reviveWithAd => '+1 生命（广告）';

  @override
  String get achievementUnlocked => '🏆 成就已解锁';

  @override
  String get statScore => '得分';

  @override
  String get statTop => '最高';

  @override
  String get statLives => '生命';

  @override
  String get statLevel => '关卡';

  @override
  String get refillLivesTooltip => '❤️ 补满生命（广告）';

  @override
  String get paused => '⏸  已暂停';

  @override
  String get start => '开始';

  @override
  String get settingsTitle => '设置';

  @override
  String get sound => '声音';

  @override
  String get soundSubtitle => '游戏音效';

  @override
  String get vibration => '振动';

  @override
  String get vibrationSubtitle => '点击时的触觉反馈';

  @override
  String get version => '版本';

  @override
  String get publisher => '发行商';

  @override
  String get shopUnavailableNow => '商店暂时不可用。';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get shopTitle => '商店';

  @override
  String get removeAds => '去除广告';

  @override
  String get removeAdsOwned => '已购买——尽情享受无广告的游戏吧！';

  @override
  String get removeAdsDescription => '永久去除横幅广告和关卡之间的广告。';

  @override
  String get unavailable => '不可用';

  @override
  String get coinPacks => '金币礼包';

  @override
  String get loading => '加载中...';

  @override
  String get shopUnavailable => '商店不可用';

  @override
  String coinsAmount(int count) {
    return '$count 金币';
  }

  @override
  String bonusAmount(int count) {
    return '+ $count 奖励';
  }

  @override
  String get priceUnavailable => '暂无';

  @override
  String get achievementsTitle => '成就';

  @override
  String get totalProgress => '总进度';

  @override
  String achievementsProgress(int unlocked, int total) {
    return '已达成 $unlocked / $total 项成就';
  }

  @override
  String get achFirstPopTitle => '第一爆';

  @override
  String get achFirstPopDesc => '戳破第一个泡泡';

  @override
  String get achPop50Title => '泡泡杀手';

  @override
  String get achPop50Desc => '累计戳破 50 个泡泡';

  @override
  String get achPop500Title => '戳泡大师';

  @override
  String get achPop500Desc => '累计戳破 500 个泡泡';

  @override
  String get achPop2000Title => '戳泡传奇';

  @override
  String get achPop2000Desc => '累计戳破 2000 个泡泡';

  @override
  String get achScore500Title => '得分 500';

  @override
  String get achScore500Desc => '单局达到 500 分';

  @override
  String get achScore2000Title => '得分 2000';

  @override
  String get achScore2000Desc => '单局达到 2000 分';

  @override
  String get achCombo5Title => '连击连发';

  @override
  String get achCombo5Desc => '2 秒内戳破 5 个泡泡';

  @override
  String get achGames25Title => '铁杆玩家';

  @override
  String get achGames25Desc => '玩 25 局游戏';

  @override
  String get dailyBonus => '每日奖励';

  @override
  String dayOfSeven(int day) {
    return '第 $day 天 / 7';
  }

  @override
  String dayShort(int day) {
    return '第$day天';
  }

  @override
  String get claim => '领取';

  @override
  String get offerRemoveAdsTitle => '告别广告';

  @override
  String get offerRemoveAdsBody => '畅玩游戏，没有横幅广告，也没有打断游戏的广告。一次购买，永久有效。';

  @override
  String offerRemoveAdsButton(String price) {
    return '去除广告 • $price';
  }

  @override
  String get later => '稍后';

  @override
  String get notificationTitle => 'Bubble Pop Saga';

  @override
  String get notificationBody => '戳几个泡泡，放松一下吧！🫧';
}
