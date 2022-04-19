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
  const CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  String newPassword = "";
  String confirmPassword = "";

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
                    const TitleText(
                      text: Strings.createNewPassword,
                      fontSize: 28,
                    ),
                    const SizedBox(height: 25),
                    MyContainer(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            hintText: Strings.newPassword,
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
                            color: AppColors.white,
                            fontSize: Dimensions.textSizeMedium,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    MyContainer(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            hintText: Strings.confirmNewPassword,
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
                            color: AppColors.white,
                            fontSize: Dimensions.textSizeMedium,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonFill(
                        text: Strings.savePassword,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CreateNewAccountScreen(),
                              ));
                        }),
                  ]))),
    );
  }

  bool validate() {
    var valid = true;
    List<String>? messages = [];
    if (newPassword.isEmpty) {
      valid = false;
      messages.add("Enter password");
    } else if (newPassword.length < 6) {
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
    if (newPassword != confirmPassword) {
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
