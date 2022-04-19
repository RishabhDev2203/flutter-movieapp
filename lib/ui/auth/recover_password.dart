import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/ui/auth/create_new_password.dart';
import 'package:flutter_firebase_ott/util/component/back_button.dart';

import '../../util/app_colors.dart';
import '../../util/component/button_fill.dart';
import '../../util/component/my_container.dart';
import '../../util/component/title_text.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
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
                      text: Strings.recoverYourPassword,
                      fontSize: 28,
                    ),
                    const SizedBox(height: 25),
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
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonFill(
                        text: Strings.next,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CreateNewPasswordScreen(),
                              ));
                        }),
                  ]))),
    );
  }
}
