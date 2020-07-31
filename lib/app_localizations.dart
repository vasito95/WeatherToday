import 'dart:ui';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations{

  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context){
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async{
  String jsonString = await rootBundle.loadString('lang/${locale.languageCode}.json');
  Map<String,dynamic> jsonMap = jsonDecode(jsonString);
  _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  return true;
  }

  String translate(String key){
    return _localizedStrings[key];
  }


}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations>{
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {

    return ['ru', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;

}















