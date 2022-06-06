import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/ui/auth/create_new_account.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_ott/ui/auth/sign_in_page.dart';
import 'package:flutter_ideal_ott_api/repository/auth_repository.dart';
import '../../bloc/api_resp_state.dart';
import '../../bloc/cubit/auth_cubit.dart';
import '../../locale/application_localizations.dart';
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
  String currentPassword = "";
  String newPassword = "";
  bool _isHiddenPassword = true;
  bool _isHiddenConfirmPassword = true;
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
                      ApplicationLocalizations.of(context)!.translate("changePassword")!,
                        style: Theme.of(context).textTheme.headline1

                    ),
                    const SizedBox(height: 25),
                    MyContainer(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: _isHiddenPassword,
                          decoration: InputDecoration(
                            hintText: ApplicationLocalizations.of(context)!.translate("currentPassword")!,
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
                                  color: AppColors.grey,
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
                            currentPassword = text;
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
                            hintText: ApplicationLocalizations.of(context)!.translate("newPassword")!,
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
                                  color: AppColors.grey,
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
                      height: 30,
                    ),
                    ButtonFill(
                        text: ApplicationLocalizations.of(context)!.translate("savePassword")!,
                        onPressed: () {
                          if(validate()) {
                            changePassword();
                          }
                        }),
                  ]))),
    );
  }

  changePassword(){
    Utility.showLoader(context);
    _authCubit?.changePassword(currentPassword,newPassword);
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
    if (currentPassword.isEmpty) {
      valid = false;
      messages.add(ApplicationLocalizations.of(context)!.translate("enterCurrentPassword")!);
    }
    if (newPassword.isEmpty) {
      valid = false;
      messages.add(ApplicationLocalizations.of(context)!.translate("enterNewPassword")!);
    }
    // else if (currentPassword.length < 6) {
    //   valid = false;
    //   messages.add("Password must contain at least 6 characters.");
    // }
    // if(currentPassword != newPassword){
    //   valid = false;
    //   messages.add("New password and confirm password not match.");
    // }
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
