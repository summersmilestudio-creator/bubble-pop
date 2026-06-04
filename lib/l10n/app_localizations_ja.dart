// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get tooltipAchievements => '実績';

  @override
  String get tooltipShop => 'ショップ';

  @override
  String get topScore => 'ハイスコア';

  @override
  String get newGame => 'プレイ';

  @override
  String get adNotAvailable => '今は広告を表示できません。';

  @override
  String get gameOver => 'ゲームオーバー';

  @override
  String scoreResult(int score) {
    return 'スコア: $score';
  }

  @override
  String get newRecord => '🏆 新記録！';

  @override
  String get lifeRegenHint => 'プレイ中は3分ごとにライフが1つ回復します。';

  @override
  String get playAgain => 'もう一度';

  @override
  String get reviveWithAd => '+1 ライフ（広告）';

  @override
  String get achievementUnlocked => '🏆 実績を解除';

  @override
  String get statScore => 'スコア';

  @override
  String get statTop => 'ベスト';

  @override
  String get statLives => 'ライフ';

  @override
  String get statLevel => 'レベル';

  @override
  String get refillLivesTooltip => '❤️ ライフ回復（広告）';

  @override
  String get paused => '⏸  一時停止';

  @override
  String get start => 'スタート';

  @override
  String get settingsTitle => '設定';

  @override
  String get sound => 'サウンド';

  @override
  String get soundSubtitle => 'ゲーム内の効果音';

  @override
  String get vibration => 'バイブレーション';

  @override
  String get vibrationSubtitle => 'タップ時の触覚フィードバック';

  @override
  String get version => 'バージョン';

  @override
  String get publisher => '発行元';

  @override
  String get shopUnavailableNow => '今はショップを利用できません。';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get shopTitle => 'ショップ';

  @override
  String get removeAds => '広告なし';

  @override
  String get removeAdsOwned => '購入済み — 広告なしでお楽しみください！';

  @override
  String get removeAdsDescription => 'バナーとレベル間の広告を永久に削除します。';

  @override
  String get unavailable => '利用不可';

  @override
  String get coinPacks => 'コインパック';

  @override
  String get loading => '読み込み中...';

  @override
  String get shopUnavailable => 'ショップ利用不可';

  @override
  String coinsAmount(int count) {
    return '$count コイン';
  }

  @override
  String bonusAmount(int count) {
    return '+ $count ボーナス';
  }

  @override
  String get priceUnavailable => 'なし';

  @override
  String get achievementsTitle => '実績';

  @override
  String get totalProgress => '全体の進捗';

  @override
  String achievementsProgress(int unlocked, int total) {
    return '$total 個中 $unlocked 個達成';
  }

  @override
  String get achFirstPopTitle => 'はじめてのポップ';

  @override
  String get achFirstPopDesc => '最初のバブルを割ろう';

  @override
  String get achPop50Title => 'バブルバスター';

  @override
  String get achPop50Desc => '合計50個のバブルを割ろう';

  @override
  String get achPop500Title => 'ポップマスター';

  @override
  String get achPop500Desc => '合計500個のバブルを割ろう';

  @override
  String get achPop2000Title => 'ポップレジェンド';

  @override
  String get achPop2000Desc => '合計2000個のバブルを割ろう';

  @override
  String get achScore500Title => 'スコア500';

  @override
  String get achScore500Desc => '1回のプレイで500点を取ろう';

  @override
  String get achScore2000Title => 'スコア2000';

  @override
  String get achScore2000Desc => '1回のプレイで2000点を取ろう';

  @override
  String get achCombo5Title => 'コンボストリーク';

  @override
  String get achCombo5Desc => '2秒以内に5個のバブルを割ろう';

  @override
  String get achGames25Title => 'やり込み';

  @override
  String get achGames25Desc => '25回プレイしよう';

  @override
  String get dailyBonus => 'デイリーボーナス';

  @override
  String dayOfSeven(int day) {
    return '$day 日目 / 7';
  }

  @override
  String dayShort(int day) {
    return '$day日';
  }

  @override
  String get claim => '受け取る';

  @override
  String get offerRemoveAdsTitle => '広告を消そう';

  @override
  String get offerRemoveAdsBody => 'バナーも、邪魔な広告もなしでプレイ。一度きり、ずっと。';

  @override
  String offerRemoveAdsButton(String price) {
    return '広告を消す • $price';
  }

  @override
  String get later => 'あとで';

  @override
  String get notificationTitle => 'Bubble Pop Saga';

  @override
  String get notificationBody => 'バブルを割ってリラックスしよう！🫧';
}
