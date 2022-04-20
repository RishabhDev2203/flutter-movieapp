import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/ui/auth/create_new_account.dart';

import '../../util/app_colors.dart';
import '../../util/component/back_button.dart';
import '../../util/component/button_fill.dart';
import '../../util/component/my_container.dart';
import '../../util/component/title_text.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';
import '../../util/utility.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  String? title;
   CreateNewPasswordScreen({Key? key,this.title}) : super(key: key);

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  String newPassword = "";
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
              padding: const EdgeInsets.only(
                left: Dimensions.marginMedium,
                right: Dimensions
                    .marginMedium, /* top: MediaQuery.of(context).padding.top + 30*/
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ButtonBack(),
                    ),
                    const SizedBox(height: 20),
                     TitleText(
                      text: widget.title??"",
                      fontSize: 28,
                    ),
                    const SizedBox(height: 25),
                    MyContainer(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: _isHiddenPassword,
                          decoration: InputDecoration(
                            hintText: Strings.newPassword,
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
                            newPassword = text;
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
                            hintText: Strings.confirmNewPassword,
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
                      height: 30,
                    ),
                    ButtonFill(
                        text: Strings.savePassword,
                        onPressed: () {
                          if(validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const CreateNewAccountScreen(),
                                ));
                          }
                        }),
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
    List<String>? messages = [];
    if (newPassword.isEmpty) {
      valid = false;
      messages.add("Enter new password");
    }
    if (confirmPassword.isEmpty) {
      valid = false;
      messages.add("Please enter confirm password.");
    } else if (newPassword.length < 6) {
      valid = false;
      messages.add("Password must contain at least 6 characters.");
    }
    if(newPassword != confirmPassword){
      valid = false;
      messages.add("New password and confirm password not match.");
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
