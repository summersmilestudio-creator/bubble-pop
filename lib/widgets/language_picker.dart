import 'package:flutter/material.dart';
import 'package:bubble_pop/l10n/app_localizations.dart';
import '../services/locale_controller.dart';

/// Bottom sheet that lets the player pick any of the supported languages
/// (or follow the device language). Selection is applied app-wide instantly.
void showLanguagePicker(BuildContext context) {
  final l = AppLocalizations.of(context)!;
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A0033),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (c) {
      final current = LocaleController.instance.notifier.value?.languageCode;
      final entries = LocaleController.languageNames.entries.toList();
      return SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                children: [
                  const Icon(Icons.language, color: Color(0xFFFF4081)),
                  const SizedBox(width: 10),
                  Text(l.language,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            _tile(c, l.languageSystem, current == null,
                () => LocaleController.instance.set(null)),
            for (final e in entries)
              _tile(c, e.value, current == e.key,
                  () => LocaleController.instance.set(Locale(e.key))),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}

Widget _tile(BuildContext c, String label, bool selected, VoidCallback onTap) {
  return ListTile(
    title: Text(label,
        style: TextStyle(
            color: selected ? const Color(0xFFFF4081) : Colors.white,
            fontWeight: selected ? FontWeight.w900 : FontWeight.w600)),
    trailing: selected ? const Icon(Icons.check, color: Color(0xFFFF4081)) : null,
    onTap: () {
      onTap();
      Navigator.pop(c);
    },
  );
}
