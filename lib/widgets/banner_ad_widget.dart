import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ads_service.dart';
import '../services/purchase_service.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _ad;

  @override
  void initState() {
    super.initState();
    if (!PurchaseService.instance.noAds) _load();
    PurchaseService.instance.noAdsNotifier.addListener(_onNoAds);
  }

  void _onNoAds() {
    if (PurchaseService.instance.noAds && _ad != null) {
      _ad!.dispose();
      if (mounted) setState(() => _ad = null);
    }
  }

  void _load() {
    final ad = BannerAd(
      adUnitId: AdsService.instance.bannerUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (a) => mounted ? setState(() => _ad = a as BannerAd) : a.dispose(),
        onAdFailedToLoad: (a, e) => a.dispose(),
      ),
    );
    ad.load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    PurchaseService.instance.noAdsNotifier.removeListener(_onNoAds);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (PurchaseService.instance.noAds) return const SizedBox.shrink();
    if (_ad == null) return const SizedBox(height: 50);
    return SizedBox(
      width: _ad!.size.width.toDouble(),
      height: _ad!.size.height.toDouble(),
      child: AdWidget(ad: _ad!),
    );
  }
}
