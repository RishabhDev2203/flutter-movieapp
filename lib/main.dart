import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_ott/bloc/cubit/home_cubit.dart';
import 'package:flutter_firebase_ott/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_ott/util/app_colors.dart';
import 'package:flutter_firebase_ott/util/app_theme.dart';
import 'package:flutter_firebase_ott/util/constants.dart';
import 'package:flutter_ideal_ott_api/ideal_ott_api.dart';
import 'package:flutter_ideal_ott_api/repository/auth_repository.dart';
import 'package:flutter_ideal_ott_api/repository/home_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'bloc/cubit/auth_cubit.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            scrollBehavior: MyBehavior(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch:
                AppTheme.createMaterialColor(Colors.blue),
                fontFamily: Constants.fontFamily,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: AppColors.red)),
            home: const Splash()),
      ),
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

