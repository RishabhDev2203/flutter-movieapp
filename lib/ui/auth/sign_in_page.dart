import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/util/app_colors.dart';
import 'package:flutter_firebase_ott/util/component/button_fill.dart';
import 'package:flutter_firebase_ott/util/component/button_outline.dart';
import 'package:flutter_firebase_ott/util/component/my_container.dart';
import 'package:flutter_firebase_ott/util/component/title_text.dart';
import 'package:flutter_firebase_ott/util/dimensions.dart';

import '../../util/strings.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.bgGradientBoxDecoration(),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Container(
          padding: EdgeInsets.only(left: Dimensions.marginMedium,right: Dimensions.marginMedium,top: MediaQuery.of(context).padding.top+30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(text: "Login to your \nprofile"),
              const SizedBox(height: 20),
              const MyContainer(
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: Strings.typeYourName,
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: Dimensions.textSizeSmall,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: Dimensions.textSizeSmall,
                    ),
                  )
              ),
              const SizedBox(height: 20),
              ButtonFill(text: "login", onPressed: (){}),
              const SizedBox(height: 20),
              ButtonOutline(text: "login as a guest", onPressed: (){})
            ],
          ),
        ),
      ),
    );
  }
}
