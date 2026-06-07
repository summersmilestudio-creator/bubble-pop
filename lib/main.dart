import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:bubble_pop/l10n/app_localizations.dart';
import 'services/notification_service.dart';
import 'services/review_service.dart';
import 'screens/home_screen.dart';
import 'services/ads_service.dart';
import 'services/purchase_service.dart';
import 'services/locale_controller.dart';
import 'widgets/remove_ads_offer.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleController.instance.load();
  await PurchaseService.instance.initialize();
  await AdsService.instance.initialize();
  ReviewService.instance.registerLaunch();
  NotificationService.instance.scheduleDailyReminderLocalized();
  runApp(const BubblePopApp());
}

class BubblePopApp extends StatefulWidget {
  const BubblePopApp({super.key});

  @override
  State<BubblePopApp> createState() => _BubblePopAppState();
}

class _BubblePopAppState extends State<BubblePopApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Show the upsell right after a full-screen ad (App Open / interstitial) closes.
    AdsService.instance.adClosedTick.addListener(_onAdClosed);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    AdsService.instance.adClosedTick.removeListener(_onAdClosed);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AdsService.instance.showAppOpenIfReady();
    }
  }

  void _onAdClosed() {
    final ctx = navigatorKey.currentContext;
    if (ctx != null) RemoveAdsOffer.maybeShow(ctx);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: LocaleController.instance.notifier,
      builder: (context, locale, _) => MaterialApp(
      title: 'Bubble Pop',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A1B9A),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF1A0033),
      ),
      home: UpgradeAlert(child: const HomeScreen()),
    ),
    );
  }
}
