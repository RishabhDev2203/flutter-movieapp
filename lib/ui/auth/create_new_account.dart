import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/ui/auth/sign_in_page.dart';
import 'package:flutter_firebase_ott/ui/home/home_page.dart';

import '../../util/app_colors.dart';
import '../../util/component/back_button.dart';
import '../../util/component/button_fill.dart';
import '../../util/component/my_container.dart';
import '../../util/component/title_text.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';
import '../../util/utility.dart';

class CreateNewAccountScreen extends StatefulWidget {
  const CreateNewAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewAccountScreen> createState() => _CreateNewAccountScreenState();
}

class _CreateNewAccountScreenState extends State<CreateNewAccountScreen> {
  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool _isHiddenPassword = true;
  bool _isHiddenConfirmPassword = true;

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
                  top: MediaQuery.of(context).padding.top + 5,
                  bottom: Dimensions.marginSmall),
              child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 50),
                    const Align(
                        alignment: Alignment.topLeft, child: ButtonBack()),
                    const SizedBox(height: 20),
                    const TitleText(
                      text: Strings.createNewAccount,
                      fontSize: 28,
                    ),
                    const SizedBox(height: 25),
                    MyContainer(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextField(
                          keyboardType: TextInputType.name,
                          textAlignVertical: TextAlignVertical.center,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            hintText: Strings.fullName,
                            prefixIcon: IconButton(
                              icon: Image.asset(
                                "assets/images/profile.png",
                                height: 20,
                                width: 20,
                              ),
                              onPressed: null,
                            ),
                            hintStyle: const TextStyle(
                              color: AppColors.white,
                              fontSize: Dimensions.textSizeMedium,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: Dimensions.textSizeMedium,
                            fontWeight: FontWeight.w400,
                          ),
                          onChanged: (text) {
                            name = text;
                          },
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    MyContainer(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlignVertical: TextAlignVertical.center,
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
                              fontSize: Dimensions.textSizeMedium,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: Dimensions.textSizeMedium,
                            fontWeight: FontWeight.w400,
                          ),
                          onChanged: (text) {
                            email = text;
                          },
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    MyContainer(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: _isHiddenPassword,
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
                              fontSize: Dimensions.textSizeMedium,
                              fontWeight: FontWeight.w400,
                            ),
                            suffixIcon: GestureDetector(
                               onTap: _passwordView,
                              child:  Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: ImageIcon(
                                  AssetImage(
                                    !_isHiddenPassword?
                                    'assets/images/eye-slash.png':
                                    'assets/images/eye.png',
                                  ),
                                  color: AppColors.eyeColor,
                                ),
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: Dimensions.textSizeMedium,
                            fontWeight: FontWeight.w400,
                          ),
                          onChanged: (text) {
                            password = text;
                          },
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    MyContainer(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: _isHiddenConfirmPassword,
                          decoration: InputDecoration(
                            hintText: Strings.confirmPassword,
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
                               onTap: _passwordConfirmView,
                              child:  Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: ImageIcon(
                                  AssetImage(
                                    !_isHiddenConfirmPassword?
                                    'assets/images/eye-slash.png':
                                    'assets/images/eye.png',
                                  ),
                                  color: AppColors.eyeColor,
                                ),
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: Dimensions.textSizeMedium,
                            fontWeight: FontWeight.w400,
                          ),
                          onChanged: (text) {
                            confirmPassword = text;
                          },
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      Strings.bothPasswordSame,
                      style: TextStyle(
                          color: AppColors.lightYellowColor,
                          fontWeight: FontWeight.w400,
                          fontSize: Dimensions.textSizeSmall),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonFill(
                        text: Strings.signUp,
                        onPressed: () {
                          if(validate())
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ));
                          }
                        }),
                    const SizedBox(height: 110),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          const TextSpan(
                              text: Strings.alreadyHaveAnAccount,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: Dimensions.textSizeMedium,
                                  fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: Strings.login,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInPage()));
                                },
                              style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: Dimensions.textSizeMedium,
                                  fontWeight: FontWeight.w600)),
                        ]),
                      ),
                    ),
                  ]))),
    );
  }
  void _passwordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }
  void _passwordConfirmView() {
    setState(() {
      _isHiddenConfirmPassword = !_isHiddenConfirmPassword;
    });
  }

  bool validate() {
    var valid = true;
    var emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.trim());
    List<String>? messages = [];
    if (name.isEmpty) {
      valid = false;
      messages.add("Enter Name");
    }
    if (email.isEmpty) {
      valid = false;
      messages.add("Enter email id.");
    } else if (!emailValid) {
      valid = false;
      messages.add("Enter valid email.");
    }
    if (password.isEmpty) {
      valid = false;
      messages.add("Enter password");
    } else if (password.length < 6) {
      valid = false;
      messages.add("Password must contain at least 6 characters.");
    }
    if (confirmPassword.isEmpty) {
      valid = false;
      messages.add("Please enter confirm password.");
    } else if (confirmPassword.length < 6) {
      valid = false;
      messages.add("Password must contain at least 6 characters.");
    }
    if (password != confirmPassword) {
      valid = false;
      messages.add("Password and confirm password not match.");
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
