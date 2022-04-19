import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/ui/home_page.dart';
import 'ui/auth/sign_in_page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      _goto(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:// Container()
        Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/images/background.png", fit: BoxFit.cover),
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: Image.asset("assets/images/logo.png"),
        // )
      ],
    )
    );
  }

  _goto(BuildContext context) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const /*HomePage()*/ SignInPage()),
                (Route<dynamic> route) => false);
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
