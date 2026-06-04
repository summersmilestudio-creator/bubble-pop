import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:bubble_pop/l10n/app_localizations.dart';
import '../services/purchase_service.dart';
import '../widgets/banner_ad_widget.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  bool _busy = false;

  Future<void> _buy(String id) async {
    if (_busy) return;
    setState(() => _busy = true);
    final ok = await PurchaseService.instance.buy(id);
    if (mounted) {
      setState(() => _busy = false);
      if (!ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.shopUnavailableNow)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final svc = PurchaseService.instance;
    final noAdsProduct = svc.productFor(PurchaseService.noAdsId);
    final coinProducts = svc.coinProducts;
    return Scaffold(
      bottomNavigationBar: const BannerAdWidget(),
      backgroundColor: const Color(0xFF1A0033),
      appBar: AppBar(
        title: Text(l.shopTitle),
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: l.restorePurchases,
            icon: const Icon(Icons.restore),
            onPressed: svc.restore,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A0033), Color(0xFF6A1B9A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: svc.noAdsNotifier,
                builder: (ctx, noAds, _) {
                  return Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: noAds
                          ? const LinearGradient(colors: [Color(0xFF66BB6A), Color(0xFF1B5E20)])
                          : const LinearGradient(colors: [Color(0xFFFF4081), Color(0xFF7C4DFF)]),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(noAds ? Icons.check_circle : Icons.block,
                                color: Colors.white, size: 32),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(l.removeAds,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          noAds ? l.removeAdsOwned : l.removeAdsDescription,
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        const SizedBox(height: 12),
                        if (!noAds)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFFFF4081),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                              ),
                              onPressed: noAdsProduct == null || _busy
                                  ? null
                                  : () => _buy(PurchaseService.noAdsId),
                              child: Text(noAdsProduct?.price ?? l.unavailable),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(l.coinPacks,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2)),
              ),
              const SizedBox(height: 12),
              if (coinProducts.isEmpty && svc.available)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(l.loading, style: const TextStyle(color: Colors.white60)),
                  ),
                ),
              if (!svc.available)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(l.shopUnavailable,
                        style: const TextStyle(color: Colors.white60)),
                  ),
                ),
              for (final pack in PurchaseService.coinPacks)
                _coinTile(context, pack, svc.productFor(pack.id)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _coinTile(BuildContext context, CoinPack pack, ProductDetails? product) {
    final l = AppLocalizations.of(context)!;
    final available = product != null && PurchaseService.instance.available;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFFFD740).withValues(alpha: 0.5)),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD740), Color(0xFFFF6F00)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.monetization_on, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.coinsAmount(pack.coins),
                      style: const TextStyle(
                          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                  if (pack.bonus > 0)
                    Text(l.bonusAmount(pack.bonus),
                        style: const TextStyle(
                            color: Color(0xFFFFCA28), fontSize: 12, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4081),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
              ),
              onPressed: !available || _busy ? null : () => _buy(pack.id),
              child: Text(product?.price ?? l.priceUnavailable),
            ),
          ],
        ),
      ),
    );
  }
}
