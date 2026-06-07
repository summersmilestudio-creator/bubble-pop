import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bubble_pop/l10n/app_localizations.dart';

/// The four in-game special powers, bought with coins and consumed during play.
enum PowerType { bomb, freeze, slow, shield }

/// Localized display name for a power.
String powerName(AppLocalizations l, PowerType t) {
  switch (t) {
    case PowerType.bomb:
      return l.powerBombName;
    case PowerType.freeze:
      return l.powerFreezeName;
    case PowerType.slow:
      return l.powerSlowName;
    case PowerType.shield:
      return l.powerShieldName;
  }
}

/// Localized one-line description for a power.
String powerDesc(AppLocalizations l, PowerType t) {
  switch (t) {
    case PowerType.bomb:
      return l.powerBombDesc;
    case PowerType.freeze:
      return l.powerFreezeDesc;
    case PowerType.slow:
      return l.powerSlowDesc;
    case PowerType.shield:
      return l.powerShieldDesc;
  }
}

/// Static presentation + balance data for a power. Names/descriptions are
/// localized at the call site (see AppLocalizations); this only holds the
/// language-independent bits (price, icon, color).
class PowerSpec {
  final PowerType type;
  final int price; // coins
  final IconData icon;
  final Color color;
  const PowerSpec(this.type, this.price, this.icon, this.color);
}

/// Inventory of consumable powers, persisted in SharedPreferences.
class PowersService {
  PowersService._();
  static final instance = PowersService._();

  static const List<PowerSpec> specs = [
    PowerSpec(PowerType.bomb, 80, Icons.bubble_chart, Color(0xFFFF6E40)),
    PowerSpec(PowerType.freeze, 60, Icons.ac_unit, Color(0xFF40C4FF)),
    PowerSpec(PowerType.slow, 50, Icons.hourglass_bottom, Color(0xFF69F0AE)),
    PowerSpec(PowerType.shield, 70, Icons.shield, Color(0xFFFFD740)),
  ];

  static PowerSpec specFor(PowerType t) =>
      specs.firstWhere((s) => s.type == t);

  String _key(PowerType t) => 'bpPower_${t.name}';

  Future<int> count(PowerType t) async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_key(t)) ?? 0;
  }

  Future<Map<PowerType, int>> all() async {
    final p = await SharedPreferences.getInstance();
    return {for (final t in PowerType.values) t: p.getInt(_key(t)) ?? 0};
  }

  Future<void> add(PowerType t, int n) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_key(t), (await count(t)) + n);
  }

  /// Consumes one of [t]. Returns false if none are available.
  Future<bool> use(PowerType t) async {
    final c = await count(t);
    if (c <= 0) return false;
    final p = await SharedPreferences.getInstance();
    await p.setInt(_key(t), c - 1);
    return true;
  }
}
