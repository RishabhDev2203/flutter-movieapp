import 'package:flutter/cupertino.dart';

import 'language_helper.dart';

class LanguageChangeProvider with ChangeNotifier {
   String? currentLanguage;
  Locale? locale;

  LanguageHelper languageHelper = LanguageHelper();

  Locale? get getlocale => locale;

  void changeLocale(String newLocale) {
    Locale convertedLocale;

    currentLanguage = newLocale;

    convertedLocale = languageHelper.convertLangNameToLocale(newLocale);
    locale = convertedLocale;
    notifyListeners();
  }

  defineCurrentLanguage(context) {
    String? definedCurrentLanguage;

    if (currentLanguage != null)
      definedCurrentLanguage = currentLanguage;
    else {
      print(
          "locale from currentData: ${Localizations.localeOf(context).toString()}");
      definedCurrentLanguage = languageHelper
          .convertLocaleToLangName(Localizations.localeOf(context).toString());
    }

    return definedCurrentLanguage;
  }
}