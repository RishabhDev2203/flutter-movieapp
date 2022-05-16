import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/ui/auth/create_new_password.dart';
import 'package:flutter_firebase_ott/ui/auth/sign_in_page.dart';
import 'package:flutter_firebase_ott/util/component/back_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ideal_ott_api/repository/auth_repository.dart';
import '../../locale/application_localizations.dart';
import '../../bloc/api_resp_state.dart';
import '../../bloc/cubit/auth_cubit.dart';
import '../../util/app_colors.dart';
import '../../util/component/button_fill.dart';
import '../../util/component/my_container.dart';
import '../../util/component/title_text.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';
import '../../util/utility.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  String email = "";
  AuthCubit? _authCubit;

  @override
  void initState() {
    _authCubit = AuthCubit(AuthRepository());
    super.initState();
  }

  @override
  void dispose() {
    _authCubit?.close();
    _authCubit = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, ResponseState>(
            bloc: _authCubit,
            listener: (context, state) {
              if (state is ResponseStateLoading) {
              } else if (state is ResponseStateError) {
                Utility.hideLoader(context);
                var error  = state.errorMessage;
                Utility.showAlertDialog(context, error);
              } else if (state is ResponseStateSuccess) {
                Utility.hideLoader(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ));
              }
            },
          ),
        ],
        child: _getBody());

  }
  _getBody(){
    return  Container(
      decoration: AppColors.bgGradientBoxDecoration(),
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
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
                     Text(
                      ApplicationLocalizations.of(context)!.translate("recoverYourPassword")!,
                         style: Theme.of(context).textTheme.headline1
                    ),
                    const SizedBox(height: 25),
                    MyContainer(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText:  ApplicationLocalizations.of(context)!.translate("email")!,
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
                          onChanged: (text){
                            email = text;
                          },
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonFill(
                        text:ApplicationLocalizations.of(context)!.translate("next")!,
                        onPressed: () {
                          if(validate()) {
                            forgotPassword();
                          }
                        }),
                  ]))),
    );
  }
  forgotPassword(){
    Utility.showLoader(context);
    _authCubit?.forgotPassword(email);
  }

  bool validate() {
    var valid = true;
    var emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    List<String>? messages = [];
    if (email.isEmpty) {
      valid = false;
      messages.add(ApplicationLocalizations.of(context)!.translate("emailValidation1")!,);
    } else if (!emailValid) {
      valid = false;
      messages.add(ApplicationLocalizations.of(context)!.translate("emailValidation2")!);
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
