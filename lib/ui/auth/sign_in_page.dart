import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/ui/auth/create_new_account.dart';
import 'package:flutter_firebase_ott/ui/auth/recover_password.dart';
import 'package:flutter_firebase_ott/util/app_colors.dart';
import 'package:flutter_firebase_ott/util/component/button_fill.dart';
import 'package:flutter_firebase_ott/util/component/button_outline.dart';
import 'package:flutter_firebase_ott/util/component/my_container.dart';
import 'package:flutter_firebase_ott/util/component/title_text.dart';
import 'package:flutter_firebase_ott/util/dimensions.dart';

import '../../util/strings.dart';
import '../../util/utility.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isHiddenPassword = true;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.bgGradientBoxDecoration(),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Container(
          padding: EdgeInsets.only(
            left: Dimensions.marginMedium,
            right: Dimensions.marginMedium,
            top: MediaQuery.of(context).padding.top +
                30, /* bottom: Dimensions.textSizeSmall*/
          ),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(
                text: Strings.loginToYourProfile,
                fontSize: 28,
              ),
              const SizedBox(height: 20),
              MyContainer(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                textAlignVertical: TextAlignVertical.center,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: Strings.email,
                  prefixIcon: IconButton(
                    icon: Image.asset(
                      "assets/images/sms.png",
                      height: 20,
                      width: 20,
                    ),
                    onPressed: null,
                  ),
                  hintStyle: const TextStyle(
                    color: AppColors.white,
                    fontSize: Dimensions.textSizeSmall,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: Dimensions.textSizeSmall,
                ),
              )),
              const SizedBox(height: 15),
              MyContainer(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                textAlignVertical: TextAlignVertical.center,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: Strings.password,
                  prefixIcon: IconButton(
                    icon: Image.asset(
                      "assets/images/lock.png",
                      height: 20,
                      width: 20,
                    ),
                    onPressed: null,
                  ),
                  hintStyle: const TextStyle(
                    color: AppColors.white,
                    fontSize: Dimensions.textSizeSmall,
                  ),
                  suffixIcon: GestureDetector(
                    // onTap: _newPasswordView,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: ImageIcon(
                        AssetImage(
                          'assets/images/eye-slash.png',
                        ),
                        color: AppColors.eyeColor,
                      ),
                    ),
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: Dimensions.textSizeSmall,
                ),
              )),
              const SizedBox(height: 15),
              Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RecoverPasswordScreen(),
                          ));
                    },
                    child: const Text(Strings.forgotPassword,
                      style: TextStyle(color: AppColors.lightYellowColor),
                    ),
                  )),
              const SizedBox(height: 25),
              ButtonFill(text: Strings.login, onPressed: () {}),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    width: 180,
                    child: MyContainer(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/google.png",
                              height: 24,
                              width: 20,
                            ),
                            const SizedBox(width: 10),
                            const Text( Strings.google,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.textSizeMedium,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 180,
                    child: MyContainer(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/apple.png",
                            height: 24,
                            width: 20,
                          ),
                          const SizedBox(width: 10),
                          const Text(Strings.apple,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.textSizeMedium,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    )),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              ButtonOutline(text: Strings.asAGuestUser, onPressed: () {}),
              const SizedBox(height: 100),
              /* const Spacer(),*/
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                        text: Strings.doNotHaveAnAccount,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: Dimensions.textSizeSmall,
                            fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: Strings.signUp,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateNewAccountScreen()));
                          },
                        style: const TextStyle(
                            color: AppColors.white,
                            fontSize: Dimensions.textSizeSmall,
                            fontWeight: FontWeight.w600)),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    var valid = true;
    List<String>? messages = [];
    if (email.isEmpty) {
      valid = false;
      messages.add("Enter Email");
    }
    if (password.isEmpty) {
      valid = false;
      messages.add("Please enter password.");
    } else if (password.length < 6) {
      valid = false;
      messages.add("Password must contain at least 6 characters.");
    }
    if (!valid) {
      var msg = "";
      for (String message in messages) {
        if (msg.isEmpty) {
          msg = message;
        } else {
          msg = msg + "\n$message";
        }
      }
      Utility.showAlertDialog(context, msg);
    }
    return valid;
  }
}
