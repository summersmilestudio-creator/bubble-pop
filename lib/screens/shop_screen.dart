import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:bubble_pop/l10n/app_localizations.dart';
import '../services/purchase_service.dart';
import '../services/powers_service.dart';
import '../services/rewards_service.dart';
import '../widgets/banner_ad_widget.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  bool _busy = false;
  final _rewards = RewardsService();
  final _powersSvc = PowersService.instance;
  int _coins = 0;
  Map<PowerType, int> _powerCounts = {for (final t in PowerType.values) t: 0};

  @override
  void initState() {
    super.initState();
    _loadCoinsPowers();
  }

  Future<void> _loadCoinsPowers() async {
    final c = await _rewards.getCoins();
    final counts = await _powersSvc.all();
    if (mounted) {
      setState(() {
        _coins = c;
        _powerCounts = counts;
      });
    }
  }

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

  Future<void> _buyPower(PowerSpec spec) async {
    final l = AppLocalizations.of(context)!;
    if (_coins < spec.price) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.notEnoughCoins)),
      );
      return;
    }
    await _rewards.addCoins(-spec.price);
    await _powersSvc.add(spec.type, 1);
    await _loadCoinsPowers();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: spec.color,
          duration: const Duration(milliseconds: 1200),
          content: Text('${powerName(l, spec.type)}  +1'),
        ),
      );
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
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFD740)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.monetization_on, color: Color(0xFFFFD740), size: 18),
                  const SizedBox(width: 6),
                  Text('$_coins',
                      style: const TextStyle(
                          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          ),
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
              // ===== Fără reclame (evidențiat în capul listei) =====
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
                                      color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
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
              // ===== Puteri (cumpărate cu monede) =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(l.powersTitle,
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 14,
                        fontWeight: FontWeight.w800, letterSpacing: 2)),
              ),
              const SizedBox(height: 12),
              for (final spec in PowersService.specs) _powerTile(context, spec),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(l.coinPacks,
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 14,
                        fontWeight: FontWeight.w800, letterSpacing: 2)),
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
                    child: Text(l.shopUnavailable, style: const TextStyle(color: Colors.white60)),
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

  Widget _powerTile(BuildContext context, PowerSpec spec) {
    final l = AppLocalizations.of(context)!;
    final owned = _powerCounts[spec.type] ?? 0;
    final canAfford = _coins >= spec.price;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: spec.color.withValues(alpha: 0.6)),
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [spec.color, spec.color.withValues(alpha: 0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(spec.icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(powerName(l, spec.type),
                      style: const TextStyle(
                          color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 2),
                  Text(powerDesc(l, spec.type),
                      style: const TextStyle(color: Colors.white60, fontSize: 11.5)),
                  const SizedBox(height: 2),
                  Text(l.powerOwnedCount(owned),
                      style: TextStyle(
                          color: spec.color, fontSize: 11, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: canAfford ? const Color(0xFFFFD740) : Colors.white24,
                foregroundColor: canAfford ? Colors.black : Colors.white54,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
              ),
              onPressed: () => _buyPower(spec),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.monetization_on, size: 16),
                  const SizedBox(width: 4),
                  Text('${spec.price}'),
                ],
              ),
            ),
          ],
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
