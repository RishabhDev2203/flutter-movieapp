import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageHelper {
   String LAGUAGE_CODE = 'languageCode';
   Future<Locale> setLocale(String languageCode) async {
     SharedPreferences _prefs = await SharedPreferences.getInstance();
     await _prefs.setString(LAGUAGE_CODE, languageCode);
     return convertLangNameToLocale(languageCode);
   }
  convertLangNameToLocale(String langNameToConvert) {
    Locale convertedLocale;

    switch (langNameToConvert) {
      case 'English':
        convertedLocale = Locale('en', 'EN');
        break;
      case 'Français':
        convertedLocale = Locale('fr', 'FR');
        break;
      case 'Español':
        convertedLocale = Locale('es', 'ES');
        break;
      case 'Русский':
        convertedLocale = Locale('ru', 'RU');
        break;
      default:
        convertedLocale = Locale('en', 'EN');
    }

    return convertedLocale;
  }

  convertLocaleToLangName(String localeToConvert) {
    String langName;

    switch (localeToConvert) {
      case 'en':
        langName = "English";
        break;
      case 'fr':
        langName = "Français";
        break;
      case 'es':
        langName = "Español";
        break;
      case 'ru':
        langName = "Русский";
        break;
      default:
        langName = "English";
    }

    return langName;
  }
}