import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/ui/auth/create_new_account.dart';
import 'package:flutter_firebase_ott/ui/auth/recover_password.dart';
import 'package:flutter_firebase_ott/ui/home/home_page.dart';
import 'package:flutter_firebase_ott/util/app_colors.dart';
import 'package:flutter_firebase_ott/util/component/button_fill.dart';
import 'package:flutter_firebase_ott/util/component/button_outline.dart';
import 'package:flutter_firebase_ott/util/component/my_container.dart';
import 'package:flutter_firebase_ott/util/component/title_text.dart';
import 'package:flutter_firebase_ott/util/dimensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ideal_ott_api/repository/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../locale/application_localizations.dart';
import '../../bloc/api_resp_state.dart';
import '../../bloc/cubit/auth_cubit.dart';
import '../../util/strings.dart';
import '../../util/utility.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = "";
  String password = "";
  bool _isHiddenPassword = true;
  AuthCubit? _authCubit;
  AuthCubit? _authGoogleCubit;
  AuthCubit? _authFacebookCubit;
  GoogleSignInAccount? _currentUser;
  var googleAccessToken = "";
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: Platform.isAndroid
          ? "353066966745-t5dsfql1ef04n48c96ld22eomnkr0g3f.apps.googleusercontent.com"
          : "353066966745-11asbh25dddcqn21gop89kpnaf8u501g.apps.googleusercontent.com"
  );
  @override
  void initState() {
    _authCubit = AuthCubit(AuthRepository());
    _authGoogleCubit = AuthCubit(AuthRepository());
    super.initState();
  }

  @override
  void dispose() {
    _authCubit?.close();
    _authGoogleCubit?.close();
    _authFacebookCubit?.close();
    _authCubit = null;
    _authGoogleCubit = null;
    _authFacebookCubit = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  MultiBlocListener(
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
                      builder: (context) => HomePage(),
                    ));
              }
            },
          ),
          BlocListener<AuthCubit, ResponseState>(
            bloc: _authGoogleCubit,
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
                      builder: (context) => HomePage(),
                    ));
              }
            },
          ),
          BlocListener<AuthCubit, ResponseState>(
            bloc: _authFacebookCubit,
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
                      builder: (context) => HomePage(),
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
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.transparent,
        body: Container(
          padding: EdgeInsets.only(
              left: Dimensions.marginMedium,
              right: Dimensions.marginMedium,
              top: MediaQuery.of(context).padding.top + 30,
              bottom: Dimensions.marginLarge),
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(ApplicationLocalizations.of(context)!.translate("loginToYourProfile")!,style:TextStyle(fontSize: 28,color: Colors.white)),
                  const SizedBox(height: 30),
                  MyContainer(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: ApplicationLocalizations.of(context)!.translate("email"),
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
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                            fontSize: Dimensions.textSizeMedium,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white),
                        onChanged: (text) {
                          email = text;
                        },
                      )),
                  const SizedBox(height: 15),
                  MyContainer(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextField(
                        obscureText: _isHiddenPassword,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: ApplicationLocalizations.of(context)!.translate("password"),
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
                              fontWeight: FontWeight.w400),
                          suffixIcon: GestureDetector(
                            onTap: _passwordView,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: ImageIcon(
                                AssetImage(
                                  !_isHiddenPassword
                                      ? 'assets/images/eye-slash.png'
                                      : 'assets/images/eye.png',
                                ),
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                            fontSize: Dimensions.textSizeMedium,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white),
                        onChanged: (text) {
                          password = text;
                        },
                      )),
                  const SizedBox(height: 15),
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const RecoverPasswordScreen(),
                              ));
                        },
                        child: Text(
                            ApplicationLocalizations.of(context)!.translate("forgotPassword")!,
                          style: TextStyle(
                              color: AppColors.lightYellowColor,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimensions.textSizeSmall),
                        ),
                      )),
                  const SizedBox(height: 25),
                  // ButtonFill(text: Strings.login, onPressed: () {}),
                  ButtonFill(
                      text: ApplicationLocalizations.of(context)!.translate("login")!,
                      onPressed: () {
                        if (validate()) {
                          loginAccount();
                        }
                      }),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                _authGoogleCubit?.apiGoogleLogin();
                              },
                              child: SizedBox(
                                height: 40,
                                child: MyContainer(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/google.png",
                                        height: 24,
                                        width: 20,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        Strings.google,
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: Dimensions.textSizeMedium,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: MyContainer(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/apple.png",
                                        height: 24,
                                        width: 20,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(Strings.apple,
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: Dimensions.textSizeMedium,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: (){
                          _authFacebookCubit?.signInWithFacebook();
                        },
                        child: SizedBox(
                          height: 40,
                          child: MyContainer(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/facebook.png",
                                  height: 24,
                                  width: 20,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  Strings.facebook,
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: Dimensions.textSizeMedium,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  ButtonOutline(text: ApplicationLocalizations.of(context)!.translate("asAGuestUser")!,
                      onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(userType: "guest"),
                        ));
                  }),
                  const Spacer(),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                           TextSpan(
                              text: ApplicationLocalizations.of(context)!.translate("doNotHaveAnAccount"),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: Dimensions.textSizeSmall,
                                  fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: ApplicationLocalizations.of(context)!.translate("signUp"),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
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
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  loginAccount(){
    Utility.showLoader(context);
    _authCubit?.loginAccount(email, password);
  }

  void _passwordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  bool validate() {
    var valid = true;
    var emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    List<String>? messages = [];
    if (email.isEmpty) {
      valid = false;
      messages.add(ApplicationLocalizations.of(context)!.translate("emailValidation1")!);
    } else if (!emailValid) {
      valid = false;
      messages.add(ApplicationLocalizations.of(context)!.translate("emailValidation2")!);
    }
    if (password.isEmpty) {
      valid = false;
      messages.add(ApplicationLocalizations.of(context)!.translate("passwordValidation1")!);
    } else if (password.length < 6) {
      valid = false;
      messages.add(ApplicationLocalizations.of(context)!.translate("passwordValidation2")!);
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