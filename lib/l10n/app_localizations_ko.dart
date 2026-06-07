// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get tooltipAchievements => '업적';

  @override
  String get tooltipShop => '상점';

  @override
  String get topScore => '최고 점수';

  @override
  String get newGame => '플레이';

  @override
  String get adNotAvailable => '지금은 광고를 사용할 수 없습니다.';

  @override
  String get gameOver => '게임 오버';

  @override
  String scoreResult(int score) {
    return '점수: $score';
  }

  @override
  String get newRecord => '🏆 신기록!';

  @override
  String get lifeRegenHint => '생명은 15분마다 하나씩 자동으로 회복됩니다.';

  @override
  String get playAgain => '새 게임';

  @override
  String get reviveWithAd => '+1 생명 (광고)';

  @override
  String get achievementUnlocked => '🏆 업적 달성';

  @override
  String get statScore => '점수';

  @override
  String get statTop => '최고';

  @override
  String get statLives => '생명';

  @override
  String get statLevel => '레벨';

  @override
  String get refillLivesTooltip => '❤️ 생명 충전 (광고)';

  @override
  String get paused => '⏸  일시정지';

  @override
  String get start => '시작';

  @override
  String get settingsTitle => '설정';

  @override
  String get sound => '소리';

  @override
  String get soundSubtitle => '게임 효과음';

  @override
  String get vibration => '진동';

  @override
  String get vibrationSubtitle => '터치 시 햅틱 피드백';

  @override
  String get version => '버전';

  @override
  String get publisher => '퍼블리셔';

  @override
  String get shopUnavailableNow => '지금은 상점을 사용할 수 없습니다.';

  @override
  String get restorePurchases => '구매 복원';

  @override
  String get shopTitle => '상점';

  @override
  String get removeAds => '광고 제거';

  @override
  String get removeAdsOwned => '구매 완료 — 광고 없이 즐기세요!';

  @override
  String get removeAdsDescription => '배너와 레벨 사이의 광고를 영구히 제거합니다.';

  @override
  String get unavailable => '사용 불가';

  @override
  String get coinPacks => '코인 팩';

  @override
  String get loading => '로딩 중...';

  @override
  String get shopUnavailable => '상점 사용 불가';

  @override
  String coinsAmount(int count) {
    return '코인 $count개';
  }

  @override
  String bonusAmount(int count) {
    return '+ $count 보너스';
  }

  @override
  String get priceUnavailable => '해당 없음';

  @override
  String get achievementsTitle => '업적';

  @override
  String get totalProgress => '전체 진행도';

  @override
  String achievementsProgress(int unlocked, int total) {
    return '$total개 중 $unlocked개 달성';
  }

  @override
  String get achFirstPopTitle => '첫 터뜨리기';

  @override
  String get achFirstPopDesc => '첫 번째 버블을 터뜨리세요';

  @override
  String get achPop50Title => '버블 버스터';

  @override
  String get achPop50Desc => '버블을 총 50개 터뜨리세요';

  @override
  String get achPop500Title => '팝 마스터';

  @override
  String get achPop500Desc => '버블을 총 500개 터뜨리세요';

  @override
  String get achPop2000Title => '팝 레전드';

  @override
  String get achPop2000Desc => '버블을 총 2000개 터뜨리세요';

  @override
  String get achScore500Title => '점수 500';

  @override
  String get achScore500Desc => '한 게임에서 500점을 달성하세요';

  @override
  String get achScore2000Title => '점수 2000';

  @override
  String get achScore2000Desc => '한 게임에서 2000점을 달성하세요';

  @override
  String get achCombo5Title => '콤보 연속';

  @override
  String get achCombo5Desc => '2초 안에 버블 5개를 터뜨리세요';

  @override
  String get achGames25Title => '열정 플레이어';

  @override
  String get achGames25Desc => '25게임을 플레이하세요';

  @override
  String get dailyBonus => '일일 보너스';

  @override
  String dayOfSeven(int day) {
    return '$day일차 / 7';
  }

  @override
  String dayShort(int day) {
    return '$day일';
  }

  @override
  String get claim => '받기';

  @override
  String get offerRemoveAdsTitle => '광고를 없애세요';

  @override
  String get offerRemoveAdsBody => '배너도, 방해되는 광고도 없이 플레이하세요. 단 한 번, 영원히.';

  @override
  String offerRemoveAdsButton(String price) {
    return '광고 제거 • $price';
  }

  @override
  String get later => '나중에';

  @override
  String get notificationTitle => 'Bubble Pop Saga';

  @override
  String get notificationBody => '버블을 터뜨리며 쉬어 가세요! 🫧';

  @override
  String get livesFull => '생명 가득';

  @override
  String nextLifeIn(String time) {
    return '다음 생명까지 $time';
  }

  @override
  String get outOfLivesTitle => '생명이 없습니다';

  @override
  String get outOfLivesBody => '회복을 기다리거나, 광고를 보거나, 코인을 사용하세요.';

  @override
  String get watchAdLife => '+1 생명 (광고)';

  @override
  String coinsLife(int coins) {
    return '+1 생명 ($coins 🪙)';
  }

  @override
  String get waitButton => '기다리기';

  @override
  String get notEnoughCoins => '코인이 부족합니다';

  @override
  String watchAdForCoins(int coins) {
    return '광고 보기 → $coins 코인';
  }

  @override
  String coinsEarned(int coins) {
    return '+$coins 코인!';
  }

  @override
  String get powersTitle => '파워';

  @override
  String get powerBombName => '폭탄';

  @override
  String get powerBombDesc => '화면의 모든 버블을 터뜨립니다';

  @override
  String get powerFreezeName => '얼리기';

  @override
  String get powerFreezeDesc => '5초 동안 버블을 멈춥니다';

  @override
  String get powerSlowName => '슬로우';

  @override
  String get powerSlowDesc => '10초 동안 버블이 절반 속도로 올라갑니다';

  @override
  String get powerShieldName => '방패';

  @override
  String get powerShieldDesc => '실수 한 번 방지: 놓친 버블이 생명을 깍지 않습니다';

  @override
  String powerOwnedCount(int count) {
    return '보유: $count';
  }

  @override
  String powerActivated(String name) {
    return '$name 발동!';
  }

  @override
  String powerNoneLeft(String name) {
    return '$name이(가) 없습니다. 상점에서 구매하세요.';
  }

  @override
  String get shieldActive => '🛡 방패 활성';

  @override
  String get buyAction => '구매';

  @override
  String get language => '언어';

  @override
  String get languageSystem => '시스템 기본값';
}
