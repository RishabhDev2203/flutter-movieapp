import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_ott/bloc/cubit/home_cubit.dart';
import 'package:flutter_firebase_ott/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_ott/theme/apptheme.dart';
import 'package:flutter_firebase_ott/theme/theme_models.dart';
import 'package:flutter_firebase_ott/ui/home/home_page.dart';
import 'package:flutter_firebase_ott/util/app_colors.dart';
import 'package:flutter_firebase_ott/util/app_theme.dart';
import 'package:flutter_firebase_ott/util/constants.dart';
import 'package:flutter_ideal_ott_api/ideal_ott_api.dart';
import 'package:flutter_ideal_ott_api/repository/auth_repository.dart';
import 'package:flutter_ideal_ott_api/repository/home_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/cubit/auth_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'locale/application_localizations.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    SharedPreferences.getInstance().then((prefs) {
      var themeMode = prefs.getInt('themeMode')  ?? 0;
      runApp(
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) =>   ThemeNotifier(ThemeMode.values[themeMode]),
          child: MyApp(),
        ),
      );
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => HomeCubit(HomeRepository()),
        ),
      ],
      child: GlobalLoaderOverlay(
        overlayOpacity: 0.1,
        child: MaterialApp(

            title: '',

            supportedLocales: [
              Locale( 'en' , 'US' ),
              Locale( 'es' , 'ES' ),
              Locale( 'fr' , 'FR' ),

            ],

            localizationsDelegates: [
              ApplicationLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocaleLanguage in supportedLocales) {
                if (supportedLocaleLanguage.languageCode == locale?.languageCode &&
                    supportedLocaleLanguage.countryCode == locale?.countryCode) {
                  return supportedLocaleLanguage;
                }
              }
              return supportedLocales.first;
            },
            scrollBehavior: MyBehavior(),
            debugShowCheckedModeBanner: false,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            themeMode: themeNotifier.getThemeMode(),
            home: const Splash()),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection){
    return child;
  }
}

