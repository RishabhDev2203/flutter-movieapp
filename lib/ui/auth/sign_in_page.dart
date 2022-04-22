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
import 'package:google_sign_in/google_sign_in.dart';
import '../../bloc/api_resp_state.dart';
import '../../bloc/cubit/auth_cubit.dart';
import '../../repository/auth_repository.dart';
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
    initGoogleLogin();
    super.initState();
  }

  @override
  void dispose() {
    _authCubit?.close();
    _authGoogleCubit?.close();
    _authCubit = null;
    _authGoogleCubit = null;
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
                      builder: (context) => const HomePage(),
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
                      builder: (context) => const HomePage(),
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
              bottom: Dimensions.marginSmall),
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleText(
                    text: Strings.loginToYourProfile,
                    fontSize: 28,
                  ),
                  const SizedBox(height: 30),
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
                        child: const Text(
                          Strings.forgotPassword,
                          style: TextStyle(
                              color: AppColors.lightYellowColor,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimensions.textSizeSmall),
                        ),
                      )),
                  const SizedBox(height: 25),
                  // ButtonFill(text: Strings.login, onPressed: () {}),
                  ButtonFill(
                      text: Strings.login,
                      onPressed: () {
                        if (validate()) {
                          loginAccount();
                        }
                      }),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                           _handleSignIn();
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
                  const SizedBox(height: 50),
                  ButtonOutline(text: Strings.asAGuestUser, onPressed: () {}),
                  const Spacer(),
                  const SizedBox(
                    height: 20,
                  ),
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
  initGoogleLogin() {
    _googleSignIn.signOut();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
  }

  Future<void> _handleSignIn() async {
    try {
      _googleSignIn.signOut();
      await _googleSignIn.signIn();
    } catch (error) {
      print(">>>>>>>>>>>>>>>>>>>>>>>..." + error.toString());
    }
  }
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    print('People API>>>>>>>>>>>>>>>>>response: ${user.displayName}');
    print('People API>>>>>>>>>>>>>>>>>response: ${user.email}');
    print('People API>>>>>>>>>>>>>>>>>response: ${user.id.toString()}');
    user.authentication.then((googleKey) {
      print(">>>>>>>>>>>>>>>>>>>>" + googleKey.accessToken.toString());
      googleAccessToken = googleKey.idToken.toString();
      if (user.id.isNotEmpty) {
        apiGoogleLoginData(user);
      }
    }).catchError((err) {
      print('inner error');
    });
  }
  void apiGoogleLoginData(GoogleSignInAccount user) {
    var accessToken = googleAccessToken;
    var socialKey = "google";
    var email = user.email;
    var name = user.displayName;
    print("googleaccesstoken>>>>>>>>>>>>>>>>>>>>>>>>" + googleAccessToken);


    _authGoogleCubit?.apiGoogleLogin(email,name!);

  }

  bool validate() {
    var valid = true;
    var emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    List<String>? messages = [];
    if (email.isEmpty) {
      valid = false;
      messages.add("Enter Email id.");
    } else if (!emailValid) {
      valid = false;
      messages.add("Enter valid email.");
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

  /*// function to implement the google signin

// creating firebase instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (result != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }*/


}