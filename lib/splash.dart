import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/ui/home/home_page.dart';
import 'package:flutter_firebase_ott/util/app_colors.dart';
import 'package:flutter_firebase_ott/util/app_session.dart';
import 'package:provider/provider.dart';
import 'locale/languageprovider.dart';
import 'ui/auth/sign_in_page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final AppSession _appSession = AppSession();

  @override
  void initState() {
    super.initState();
    _appSession.init().then((value) => {
      Timer(const Duration(seconds: 2), () {
        _goto(context);
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).backgroundColor,

    body:
        Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
         // child: Image.asset("assets/images/background.png", fit: BoxFit.cover),
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: Image.asset("assets/images/logo.png"),
        // )
      ],
    )
    );
  }

  _goto(BuildContext context)  async {
    var language= await _appSession.getUserLangauge();
    var consumer = Provider.of<LanguageChangeProvider>(context, listen: false);
    if(language=='Français') {
      consumer.changeLocale(language ?? "");
    }else if(language=='Español'){
      consumer.changeLocale(language ?? "");
    }else{
      consumer.changeLocale("English");
    }

    if(FirebaseAuth.instance.currentUser== null){
           Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const SignInPage()),

                    (Route<dynamic> route) => false);
          }else{
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const HomePage()),

                    (Route<dynamic> route) => false);

          }
    }
  // _goto(BuildContext context) async {
  //   var dto = await AppSession().getUserDetail();
  //   if(dto != null && dto.result != null){
  //     if (dto.result?.userType ==
  //         Constants.USER_TYPE_COMPANY) {
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(
  //               builder: (context) => const MainMenuEmployer()),
  //               (Route<dynamic> route) => false);
  //     } else {
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(
  //               builder: (context) => const MainMenuIndividual()),
  //               (Route<dynamic> route) => false);
  //     }
  //   }else {
  //     Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (context) => const WelcomePage()));
  //   }

}
