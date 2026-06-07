import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// Tooltip for the achievements button on the home screen
  ///
  /// In ro, this message translates to:
  /// **'Realizări'**
  String get tooltipAchievements;

  /// Tooltip for the shop button on the home screen
  ///
  /// In ro, this message translates to:
  /// **'Magazin'**
  String get tooltipShop;

  /// Label above the best score on the home screen
  ///
  /// In ro, this message translates to:
  /// **'TOP SCORE'**
  String get topScore;

  /// Main play button on the home screen
  ///
  /// In ro, this message translates to:
  /// **'JOC NOU'**
  String get newGame;

  /// Snackbar shown when a rewarded ad cannot be displayed
  ///
  /// In ro, this message translates to:
  /// **'Reclama nu e disponibilă acum.'**
  String get adNotAvailable;

  /// Title of the game over dialog
  ///
  /// In ro, this message translates to:
  /// **'Game Over'**
  String get gameOver;

  /// Final score shown in the game over dialog
  ///
  /// In ro, this message translates to:
  /// **'Scor: {score}'**
  String scoreResult(int score);

  /// Appended below the score when the player beats their high score
  ///
  /// In ro, this message translates to:
  /// **'🏆 Record!'**
  String get newRecord;

  /// Hint in the game over dialog about regaining lives over time
  ///
  /// In ro, this message translates to:
  /// **'Viețile se refac singure, câte una la fiecare 15 minute.'**
  String get lifeRegenHint;

  /// Button to start a fresh game from the game over dialog
  ///
  /// In ro, this message translates to:
  /// **'Joc nou'**
  String get playAgain;

  /// Button to revive with one extra life by watching a rewarded ad
  ///
  /// In ro, this message translates to:
  /// **'+1 viață (reclamă)'**
  String get reviveWithAd;

  /// Header of the toast shown when an achievement is unlocked
  ///
  /// In ro, this message translates to:
  /// **'🏆 Realizare deblocată'**
  String get achievementUnlocked;

  /// In-game HUD label for current score
  ///
  /// In ro, this message translates to:
  /// **'SCOR'**
  String get statScore;

  /// In-game HUD label for best score
  ///
  /// In ro, this message translates to:
  /// **'TOP'**
  String get statTop;

  /// In-game HUD label for remaining lives
  ///
  /// In ro, this message translates to:
  /// **'VIEȚI'**
  String get statLives;

  /// In-game HUD label for current difficulty level
  ///
  /// In ro, this message translates to:
  /// **'NIVEL'**
  String get statLevel;

  /// Tooltip for the button that refills all lives via a rewarded ad
  ///
  /// In ro, this message translates to:
  /// **'❤️ Refill vieți (reclamă)'**
  String get refillLivesTooltip;

  /// Overlay text shown when the game is paused
  ///
  /// In ro, this message translates to:
  /// **'⏸  Pauză'**
  String get paused;

  /// Button to start the game
  ///
  /// In ro, this message translates to:
  /// **'START'**
  String get start;

  /// App bar title for the settings screen
  ///
  /// In ro, this message translates to:
  /// **'Setări'**
  String get settingsTitle;

  /// Sound toggle title in settings
  ///
  /// In ro, this message translates to:
  /// **'Sunet'**
  String get sound;

  /// Sound toggle subtitle in settings
  ///
  /// In ro, this message translates to:
  /// **'Efecte sonore în joc'**
  String get soundSubtitle;

  /// Vibration toggle title in settings
  ///
  /// In ro, this message translates to:
  /// **'Vibrații'**
  String get vibration;

  /// Vibration toggle subtitle in settings
  ///
  /// In ro, this message translates to:
  /// **'Haptic feedback la atingere'**
  String get vibrationSubtitle;

  /// Version row title in settings
  ///
  /// In ro, this message translates to:
  /// **'Versiune'**
  String get version;

  /// Publisher row title in settings
  ///
  /// In ro, this message translates to:
  /// **'Publisher'**
  String get publisher;

  /// Snackbar when a purchase cannot be started
  ///
  /// In ro, this message translates to:
  /// **'Magazinul nu este disponibil acum.'**
  String get shopUnavailableNow;

  /// Tooltip for the restore purchases button
  ///
  /// In ro, this message translates to:
  /// **'Restaurează cumpărăturile'**
  String get restorePurchases;

  /// App bar title for the shop screen
  ///
  /// In ro, this message translates to:
  /// **'Magazin'**
  String get shopTitle;

  /// Title of the no-ads purchase card
  ///
  /// In ro, this message translates to:
  /// **'Fără reclame'**
  String get removeAds;

  /// Shown on the no-ads card once it has been purchased
  ///
  /// In ro, this message translates to:
  /// **'Achiziționat — bucură-te de joc fără reclame!'**
  String get removeAdsOwned;

  /// Description on the no-ads card before purchase
  ///
  /// In ro, this message translates to:
  /// **'Elimină banner-ele și reclamele între nivele permanent.'**
  String get removeAdsDescription;

  /// Fallback label when the no-ads product price is not loaded
  ///
  /// In ro, this message translates to:
  /// **'Indisponibil'**
  String get unavailable;

  /// Section header for the coin packs in the shop
  ///
  /// In ro, this message translates to:
  /// **'PACHETE MONEDE'**
  String get coinPacks;

  /// Shown while coin products are loading
  ///
  /// In ro, this message translates to:
  /// **'Se încarcă...'**
  String get loading;

  /// Shown when the store is not available at all
  ///
  /// In ro, this message translates to:
  /// **'Magazin indisponibil'**
  String get shopUnavailable;

  /// Number of coins in a coin pack
  ///
  /// In ro, this message translates to:
  /// **'{count} monede'**
  String coinsAmount(int count);

  /// Bonus coins added to a coin pack
  ///
  /// In ro, this message translates to:
  /// **'+ {count} BONUS'**
  String bonusAmount(int count);

  /// Fallback label when a coin pack price is not loaded
  ///
  /// In ro, this message translates to:
  /// **'N/A'**
  String get priceUnavailable;

  /// App bar title for the achievements screen
  ///
  /// In ro, this message translates to:
  /// **'Realizări'**
  String get achievementsTitle;

  /// Header of the achievements progress card
  ///
  /// In ro, this message translates to:
  /// **'Progres total'**
  String get totalProgress;

  /// How many achievements have been unlocked out of the total
  ///
  /// In ro, this message translates to:
  /// **'{unlocked} din {total} realizări'**
  String achievementsProgress(int unlocked, int total);

  /// Achievement title: pop your first bubble
  ///
  /// In ro, this message translates to:
  /// **'Prima Bulă'**
  String get achFirstPopTitle;

  /// Achievement description: pop your first bubble
  ///
  /// In ro, this message translates to:
  /// **'Sparge prima bulă'**
  String get achFirstPopDesc;

  /// Achievement title: pop 50 bubbles total
  ///
  /// In ro, this message translates to:
  /// **'Spărgător de Bule'**
  String get achPop50Title;

  /// Achievement description: pop 50 bubbles total
  ///
  /// In ro, this message translates to:
  /// **'Sparge 50 de bule total'**
  String get achPop50Desc;

  /// Achievement title: pop 500 bubbles total
  ///
  /// In ro, this message translates to:
  /// **'Maestru al Bulelor'**
  String get achPop500Title;

  /// Achievement description: pop 500 bubbles total
  ///
  /// In ro, this message translates to:
  /// **'Sparge 500 de bule total'**
  String get achPop500Desc;

  /// Achievement title: pop 2000 bubbles total
  ///
  /// In ro, this message translates to:
  /// **'Legendă a Bulelor'**
  String get achPop2000Title;

  /// Achievement description: pop 2000 bubbles total
  ///
  /// In ro, this message translates to:
  /// **'Sparge 2000 de bule total'**
  String get achPop2000Desc;

  /// Achievement title: reach score 500 in one game
  ///
  /// In ro, this message translates to:
  /// **'Scor 500'**
  String get achScore500Title;

  /// Achievement description: reach score 500 in one game
  ///
  /// In ro, this message translates to:
  /// **'Atinge scorul 500 într-o partidă'**
  String get achScore500Desc;

  /// Achievement title: reach score 2000 in one game
  ///
  /// In ro, this message translates to:
  /// **'Scor 2000'**
  String get achScore2000Title;

  /// Achievement description: reach score 2000 in one game
  ///
  /// In ro, this message translates to:
  /// **'Atinge scorul 2000 într-o partidă'**
  String get achScore2000Desc;

  /// Achievement title: pop 5 bubbles within 2 seconds
  ///
  /// In ro, this message translates to:
  /// **'Serie Combo'**
  String get achCombo5Title;

  /// Achievement description: pop 5 bubbles within 2 seconds
  ///
  /// In ro, this message translates to:
  /// **'Sparge 5 bule în 2 secunde'**
  String get achCombo5Desc;

  /// Achievement title: play 25 games
  ///
  /// In ro, this message translates to:
  /// **'Dedicat'**
  String get achGames25Title;

  /// Achievement description: play 25 games
  ///
  /// In ro, this message translates to:
  /// **'Joacă 25 de partide'**
  String get achGames25Desc;

  /// Title of the daily reward screen
  ///
  /// In ro, this message translates to:
  /// **'BONUS ZILNIC'**
  String get dailyBonus;

  /// Which day of the 7-day streak the reward is for
  ///
  /// In ro, this message translates to:
  /// **'Ziua {day} / 7'**
  String dayOfSeven(int day);

  /// Short day label inside each daily reward cell (e.g. day 1 -> Z1)
  ///
  /// In ro, this message translates to:
  /// **'Z{day}'**
  String dayShort(int day);

  /// Button to claim the daily reward
  ///
  /// In ro, this message translates to:
  /// **'PRIMEȘTE'**
  String get claim;

  /// Title of the remove-ads house promo dialog
  ///
  /// In ro, this message translates to:
  /// **'Scapă de reclame'**
  String get offerRemoveAdsTitle;

  /// Body of the remove-ads house promo dialog
  ///
  /// In ro, this message translates to:
  /// **'Joacă fără bannere și fără reclame care te întrerup. O singură dată, pentru totdeauna.'**
  String get offerRemoveAdsBody;

  /// Buy button on the remove-ads promo dialog, with the store price
  ///
  /// In ro, this message translates to:
  /// **'Elimină reclamele • {price}'**
  String offerRemoveAdsButton(String price);

  /// Dismiss button on the remove-ads promo dialog
  ///
  /// In ro, this message translates to:
  /// **'Mai târziu'**
  String get later;

  /// Re-engagement notification title (used via device locale, no context)
  ///
  /// In ro, this message translates to:
  /// **'Bubble Pop Saga'**
  String get notificationTitle;

  /// Re-engagement notification body (used via device locale, no context)
  ///
  /// In ro, this message translates to:
  /// **'Sparge niște bule și relaxează-te! 🫧'**
  String get notificationBody;

  /// Shown on the home screen when the player has the maximum number of lives
  ///
  /// In ro, this message translates to:
  /// **'Vieți pline'**
  String get livesFull;

  /// Countdown on the home screen until the next life regenerates
  ///
  /// In ro, this message translates to:
  /// **'Următoarea viață în {time}'**
  String nextLifeIn(String time);

  /// Title of the dialog shown when trying to play with zero lives
  ///
  /// In ro, this message translates to:
  /// **'Nu mai ai vieți'**
  String get outOfLivesTitle;

  /// Body of the out-of-lives dialog
  ///
  /// In ro, this message translates to:
  /// **'Așteaptă refacerea lor, vezi o reclamă sau folosește monede.'**
  String get outOfLivesBody;

  /// Button to gain one life by watching a rewarded ad
  ///
  /// In ro, this message translates to:
  /// **'+1 viață (reclamă)'**
  String get watchAdLife;

  /// Button to buy one life with coins
  ///
  /// In ro, this message translates to:
  /// **'+1 viață ({coins} 🪙)'**
  String coinsLife(int coins);

  /// Dismiss button on the out-of-lives dialog
  ///
  /// In ro, this message translates to:
  /// **'Aștept'**
  String get waitButton;

  /// Snackbar shown when the player cannot afford something with coins
  ///
  /// In ro, this message translates to:
  /// **'Nu ai destule monede'**
  String get notEnoughCoins;

  /// Home screen button offering coins in exchange for watching a rewarded ad
  ///
  /// In ro, this message translates to:
  /// **'Vezi o reclamă → {coins} monede'**
  String watchAdForCoins(int coins);

  /// Snackbar confirming coins earned from a rewarded ad
  ///
  /// In ro, this message translates to:
  /// **'+{coins} monede!'**
  String coinsEarned(int coins);

  /// Section header for special powers (shop and in-game)
  ///
  /// In ro, this message translates to:
  /// **'PUTERI'**
  String get powersTitle;

  /// Name of the bomb power
  ///
  /// In ro, this message translates to:
  /// **'Bombă'**
  String get powerBombName;

  /// Description of the bomb power
  ///
  /// In ro, this message translates to:
  /// **'Sparge toate baloanele de pe ecran'**
  String get powerBombDesc;

  /// Name of the freeze power
  ///
  /// In ro, this message translates to:
  /// **'Înghețare'**
  String get powerFreezeName;

  /// Description of the freeze power
  ///
  /// In ro, this message translates to:
  /// **'Oprește baloanele 5 secunde'**
  String get powerFreezeDesc;

  /// Name of the slow-motion power
  ///
  /// In ro, this message translates to:
  /// **'Încetinitor'**
  String get powerSlowName;

  /// Description of the slow-motion power
  ///
  /// In ro, this message translates to:
  /// **'Baloanele urcă cu jumătate de viteză 10 secunde'**
  String get powerSlowDesc;

  /// Name of the shield power
  ///
  /// In ro, this message translates to:
  /// **'Scut'**
  String get powerShieldName;

  /// Description of the shield power
  ///
  /// In ro, this message translates to:
  /// **'Blochează o ratare — un balon scăpat nu îți ia viață'**
  String get powerShieldDesc;

  /// How many of a given power the player owns
  ///
  /// In ro, this message translates to:
  /// **'Ai: {count}'**
  String powerOwnedCount(int count);

  /// Snackbar when a power is activated in-game
  ///
  /// In ro, this message translates to:
  /// **'{name} activat!'**
  String powerActivated(String name);

  /// Snackbar when the player taps an empty power
  ///
  /// In ro, this message translates to:
  /// **'Nu mai ai {name}. Cumpără din magazin.'**
  String powerNoneLeft(String name);

  /// Overlay badge shown while the shield power is active
  ///
  /// In ro, this message translates to:
  /// **'🛡 Scut activ'**
  String get shieldActive;

  /// Generic buy button label
  ///
  /// In ro, this message translates to:
  /// **'Cumpără'**
  String get buyAction;

  /// Language picker title
  ///
  /// In ro, this message translates to:
  /// **'Limbă'**
  String get language;

  /// Follow device language option
  ///
  /// In ro, this message translates to:
  /// **'Implicit (sistem)'**
  String get languageSystem;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'ko',
    'pt',
    'ro',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
