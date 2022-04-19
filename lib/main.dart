import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_ott/splash.dart';
import 'package:flutter_firebase_ott/util/app_colors.dart';
import 'package:flutter_firebase_ott/util/app_theme.dart';
import 'package:flutter_firebase_ott/util/constants.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayOpacity: 0.1,
      child: MaterialApp(
          title: '',
          scrollBehavior: MyBehavior(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch:
              AppTheme.createMaterialColor(Colors.blue),
              //scaffoldBackgroundColor: AppColors.bg,
              fontFamily: Constants.fontFamily,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: AppColors.red)),
          home: const Splash()),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

