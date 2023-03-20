import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  Locale local = const Locale('en', 'US');

  AppLocalization(this.local);

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  late Map<String, String> _localizationValue;

  Future load() async {
    String jsonStringValue =
        await rootBundle.loadString("lib/lang/${local.languageCode}.json");
    Map<String, dynamic> mapResponse = jsonDecode(jsonStringValue);
    _localizationValue =
        mapResponse.map((key, value) => MapEntry(key, value.toString()));
  }

  String? getConvertedValue(String key) {
    return _localizationValue[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      AppLocalizationsDelegate();
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    //return SynchronousFuture<AppLocalization>(AppLocalization(locale));
    AppLocalization appLocalization = AppLocalization(locale);
    await appLocalization.load();
    return appLocalization;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
