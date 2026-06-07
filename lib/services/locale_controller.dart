import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// In-app language override. `null` means "follow the device language".
/// The chosen language is persisted so it survives restarts.
class LocaleController {
  LocaleController._();
  static final instance = LocaleController._();

  static const _key = 'appLocale';
  final ValueNotifier<Locale?> notifier = ValueNotifier<Locale?>(null);

  /// Native names for every supported language, shown in the picker.
  static const Map<String, String> languageNames = {
    'en': 'English',
    'es': 'Español',
    'fr': 'Français',
    'it': 'Italiano',
    'ja': '日本語',
    'ko': '한국어',
    'pt': 'Português',
    'ru': 'Русский',
    'zh': '中文',
    'de': 'Deutsch',
    'ro': 'Română',
  };

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    final code = p.getString(_key);
    if (code != null && code.isNotEmpty) notifier.value = Locale(code);
  }

  Future<void> set(Locale? locale) async {
    notifier.value = locale;
    final p = await SharedPreferences.getInstance();
    if (locale == null) {
      await p.remove(_key);
    } else {
      await p.setString(_key, locale.languageCode);
    }
  }
}
