import 'package:flutter/material.dart';
import 'package:bubble_pop/l10n/app_localizations.dart';
import '../services/rewards_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _settings = SettingsService();
  bool _sound = true;
  bool _haptic = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final s = await _settings.soundOn();
    final h = await _settings.hapticOn();
    if (mounted) setState(() { _sound = s; _haptic = h; });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF1A0033),
      appBar: AppBar(
        title: Text(l.settingsTitle),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              activeColor: const Color(0xFFFF4081),
              title: Text(l.sound, style: const TextStyle(color: Colors.white)),
              subtitle: Text(l.soundSubtitle,
                  style: const TextStyle(color: Colors.white60)),
              value: _sound,
              onChanged: (v) async {
                await _settings.setSound(v);
                setState(() => _sound = v);
              },
              secondary: const Icon(Icons.volume_up, color: Color(0xFFFF4081)),
            ),
            SwitchListTile(
              activeColor: const Color(0xFFFF4081),
              title: Text(l.vibration, style: const TextStyle(color: Colors.white)),
              subtitle: Text(l.vibrationSubtitle,
                  style: const TextStyle(color: Colors.white60)),
              value: _haptic,
              onChanged: (v) async {
                await _settings.setHaptic(v);
                setState(() => _haptic = v);
              },
              secondary: const Icon(Icons.vibration, color: Color(0xFFFF4081)),
            ),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.white60),
              title: Text(l.version, style: const TextStyle(color: Colors.white)),
              subtitle: const Text('1.1.0', style: TextStyle(color: Colors.white60)),
            ),
            ListTile(
              leading: const Icon(Icons.business, color: Colors.white60),
              title: Text(l.publisher, style: const TextStyle(color: Colors.white)),
              subtitle: const Text('Summer Smile SRL', style: TextStyle(color: Colors.white60)),
            ),
          ],
        ),
      ),
    );
  }
}
