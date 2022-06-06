import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/bloc/cubit/auth_cubit.dart';
import 'package:flutter_firebase_ott/ui/auth/sign_in_page.dart';
import 'package:flutter_ideal_ott_api/repository/auth_repository.dart';
import 'package:uuid/uuid.dart';
import '../../bloc/api_resp_state.dart';
import '../../locale/application_localizations.dart';
import '../../util/app_colors.dart';
import '../../util/component/back_button.dart';
import '../../util/component/button_fill.dart';
import '../../util/component/my_container.dart';
import '../../util/component/title_text.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';
import '../../util/utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home/home_page.dart';

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
                      builder: (context) => HomePage(),
                    ));
              }
            },
          ),
        ],
        child: _getBody());
  }

  _getBody(){
    return Container(
      decoration: AppColors.bgGradientBoxDecoration(),
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.marginMedium,
                  right: Dimensions.marginMedium,
                  top: MediaQuery.of(context).padding.top + 30,
                  bottom: Dimensions.marginSmall),
              child: CustomScrollView(
               slivers : [SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 50),
                        const Align(
                            alignment: Alignment.topLeft, child: ButtonBack()),
                        const SizedBox(height: 20),
                         Text(
                          ApplicationLocalizations.of(context)!.translate("createNewAccount")!,
                             style: Theme.of(context).textTheme.headline1
                        ),
                        const SizedBox(height: 25),
                        MyContainer(
                            padding: const EdgeInsets.only(right: 10),
                            child: TextField(
                              keyboardType: TextInputType.name,
                              textAlignVertical: TextAlignVertical.center,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                hintText: ApplicationLocalizations.of(context)!.translate("fullName")!,
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
                                hintText: ApplicationLocalizations.of(context)!.translate("email")!,
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
                                hintText: ApplicationLocalizations.of(context)!.translate("password")!,
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
                                hintText: ApplicationLocalizations.of(context)!.translate("confirmPassword")!,
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: ImageIcon(
                                      AssetImage(
                                        !_isHiddenConfirmPassword
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
                         Text(
                           ApplicationLocalizations.of(context)!.translate("bothPasswordSame")!,
                             style: Theme.of(context).textTheme.bodyText1
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ButtonFill(
                            text:ApplicationLocalizations.of(context)!.translate("signUp")!,
                            onPressed: () {
                              if(validate())
                              {
                                createAccount();
                              }
                            }),
                        const Spacer(),
                        const SizedBox(height: 50,),
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: <TextSpan>[
                               TextSpan(
                                  text: ApplicationLocalizations.of(context)!.translate("alreadyHaveAnAccount")!,
                                   style: Theme.of(context).textTheme.headline2),
                              TextSpan(
                                  text: ApplicationLocalizations.of(context)!.translate("login")!,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignInPage()));
                                    },
                                  style: Theme.of(context).textTheme.headline3),
                            ]),
                          ),
                        ),
                      ]),
                ),
                ]
              ))),
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
      messages.add(ApplicationLocalizations.of(context)!.translate("nameValidation")!,);
    }
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
    }
    if (confirmPassword.isEmpty) {
      valid = false;
      messages.add(ApplicationLocalizations.of(context)!.translate("confirmPasswordValidation")!);
    } else if (confirmPassword.length < 6) {
      valid = false;
      messages.add(ApplicationLocalizations.of(context)!.translate("passwordValidation2")!);
    }
    if (password != confirmPassword) {
      valid = false;
      messages.add(ApplicationLocalizations.of(context)!.translate("bothPasswordValidation")!);
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

  createAccount(){
    Utility.showLoader(context);
    var uuid = const Uuid();
    _authCubit?.createAccount(name, email, password, uuid.v4());
  }
}
