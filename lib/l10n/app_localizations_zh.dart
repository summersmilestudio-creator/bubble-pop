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
  String get lifeRegenHint => '生命会自动恢复，每15分钟恢复一个。';

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

  @override
  String get livesFull => '生命已满';

  @override
  String nextLifeIn(String time) {
    return '下一个生命还需 $time';
  }

  @override
  String get outOfLivesTitle => '没有生命了';

  @override
  String get outOfLivesBody => '等待恢复、观看广告或使用金币。';

  @override
  String get watchAdLife => '+1 生命（广告）';

  @override
  String coinsLife(int coins) {
    return '+1 生命（$coins 🪙）';
  }

  @override
  String get waitButton => '等待';

  @override
  String get notEnoughCoins => '金币不足';

  @override
  String watchAdForCoins(int coins) {
    return '观看广告 → $coins 金币';
  }

  @override
  String coinsEarned(int coins) {
    return '+$coins 金币！';
  }

  @override
  String get powersTitle => '道具';

  @override
  String get powerBombName => '炸弹';

  @override
  String get powerBombDesc => '炸破屏幕上所有泡泡';

  @override
  String get powerFreezeName => '冰冻';

  @override
  String get powerFreezeDesc => '让泡泡静止５秒';

  @override
  String get powerSlowName => '慢动作';

  @override
  String get powerSlowDesc => '泡泡以一半速度上升１０秒';

  @override
  String get powerShieldName => '护盾';

  @override
  String get powerShieldDesc => '抵挡一次失误：漏掉的泡泡不会扣生命';

  @override
  String powerOwnedCount(int count) {
    return '拥有：$count';
  }

  @override
  String powerActivated(String name) {
    return '$name 已启动！';
  }

  @override
  String powerNoneLeft(String name) {
    return '没有$name了，去商店购买。';
  }

  @override
  String get shieldActive => '🛡 护盾生效';

  @override
  String get buyAction => '购买';
}
