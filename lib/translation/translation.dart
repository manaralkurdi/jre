// lib/utils/app_localizations.dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  // Static map to cache loaded translations
  static final Map<String, Map<String, String>> _localizedValues = {

  };

  AppLocalizations(this.locale);

  // Helper method to get localized instance in widgets
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // Delegate for Flutter's localization system
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // Load translations from JSON files
  Future<bool> load() async {
    // If we already have loaded this locale's translations, don't reload
    if (_localizedValues.containsKey(locale.languageCode)) {
      return true;
    }

    // Load the language JSON file from the assets
    final String jsonString = await rootBundle.loadString(
        'assets/translations/${locale.languageCode}.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Convert the dynamic JSON values to strings
    _localizedValues[locale.languageCode] = {};
    jsonMap.forEach((key, value) {
      _localizedValues[locale.languageCode]![key] = value.toString();
    });

    return true;
  }

  // Lookup a message in current locale
  String translate(String key) {
    if (_localizedValues.containsKey(locale.languageCode) &&
        _localizedValues[locale.languageCode]!.containsKey(key)) {
      return _localizedValues[locale.languageCode]![key]!;
    }

    // If we have no translation, return the key as fallback
    return key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  // List of all supported locale language codes
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'fr', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}

// Extension to make it easier to access translations
extension TranslateX on String {
  String tr(BuildContext context) {
    return AppLocalizations.of(context).translate(this);
  }
}