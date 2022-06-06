import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ideal_ott_api/dto/user_dto.dart';
import 'package:flutter_ideal_ott_api/repository/auth_repository.dart';

import '../../bloc/api_resp_state.dart';
import '../../bloc/cubit/auth_cubit.dart';
import '../../util/app_colors.dart';
import '../../util/app_session.dart';
import '../../util/component/back_button.dart';
import '../../util/constants.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';
import '../../util/utility.dart';
import '../auth/create_new_password.dart';
import '../auth/sign_in_page.dart';
import 'edit_profile.dart';
import 'link_with_tv_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthCubit? _authCubit;
  AuthCubit? _googleSignOutCubit;
  AuthCubit? _fbSignOutCubit;
  final AppSession _appSession = AppSession();
  UserDto? userDto;

  @override
  void initState() {
    _authCubit = AuthCubit(AuthRepository());
    _googleSignOutCubit = AuthCubit(AuthRepository());
    _fbSignOutCubit = AuthCubit(AuthRepository());
    _appSession.init().then((value) => getDetail());
    super.initState();
  }

  @override
  void dispose() {
    _authCubit?.close();
    _googleSignOutCubit?.close();
    _fbSignOutCubit?.close();
    _authCubit = null;
    _googleSignOutCubit = null;
    _fbSignOutCubit = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<AuthCubit, ResponseState>(
        bloc: _authCubit,
        listener: (context, state) {
          if (state is ResponseStateLoading) {
          } else if (state is ResponseStateError) {
            Utility.hideLoader(context);
            var error = state.errorMessage;
            Utility.showAlertDialog(context, error);
          } else if (state is ResponseStateSuccess) {
            Utility.hideLoader(context);
            AppSession().removeUserDetail();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const /*HomePage()*/ SignInPage()),
                (Route<dynamic> route) => false);
          }
        },
      ),
      BlocListener<AuthCubit, ResponseState>(
        bloc: _googleSignOutCubit,
        listener: (context, state) {
          if (state is ResponseStateLoading) {
          } else if (state is ResponseStateError) {
            Utility.hideLoader(context);
            var error = state.errorMessage;
            Utility.showAlertDialog(context, error);
          } else if (state is ResponseStateSuccess) {
            Utility.hideLoader(context);
            AppSession().removeUserDetail();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const /*HomePage()*/ SignInPage()),
                (Route<dynamic> route) => false);
          }
        },
      ),
      BlocListener<AuthCubit, ResponseState>(
        bloc: _fbSignOutCubit,
        listener: (context, state) {
          if (state is ResponseStateLoading) {
          } else if (state is ResponseStateError) {
            Utility.hideLoader(context);
            var error = state.errorMessage;
            Utility.showAlertDialog(context, error);
          } else if (state is ResponseStateSuccess) {
            Utility.hideLoader(context);
            AppSession().removeUserDetail();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const /*HomePage()*/ SignInPage()),
                (Route<dynamic> route) => false);
          }
        },
      ),
    ], child: _getBody());
  }

  _getBody() {
    return Container(
      decoration: AppColors.bgGradientBoxDecoration(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.transparent,
        body: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: Dimensions.marginMedium,
              right: Dimensions.marginMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ButtonBack(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EditProfilePage())).then((value) =>
                          {_appSession.init().then((value) => getDetail())});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        height: 36,
                        width: 90,
                        decoration: BoxDecoration(
                          color: AppColors.red,
                          // border: Border.all(color: AppColors.containerBorder),
                          borderRadius: BorderRadius.circular(
                              Dimensions.cornerRadiusMedium),
                        ),
                        child: const Center(
                            child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              _imageView(),
              const SizedBox(
                height: 5,
              ),
              Text(
                userDto?.name ?? "",
                style: const TextStyle(
                    color: AppColors.white,
                    fontSize: Dimensions.textSizeMedium,
                    fontFamily: Constants.fontFamily,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                userDto?.email ?? "",
                style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: Dimensions.textSizeSmall,
                    fontFamily: Constants.fontFamily,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Divider(
                  color: AppColors.divider,
                  thickness: 1,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.only(
                      top: 25, bottom: 25, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: AppColors.myContainerColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.cornerRadiusMedium),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateNewPasswordScreen(
                                    title: Strings.changePassword),
                              ));
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              "assets/images/lock.png",
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Change Password",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: Dimensions.textSizeMedium,
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: AppColors.black,
                        thickness: 1,
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LinkWithTV(title: Strings.linkWithTV),
                              ));
                        },
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.connected_tv,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              Strings.linkWithTV,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: Dimensions.textSizeMedium,
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: AppColors.black,
                        thickness: 1,
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          logoutAccount();
                          apiSignOutGoogle();
                          apiSignOutFacebook();
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              "assets/images/logout.png",
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Logout",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: Dimensions.textSizeMedium,
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  logoutAccount() {
    Utility.showLoader(context);
    _authCubit?.logoutAccount();
  }

  apiSignOutGoogle() {
    // Utility.showLoader(context);
    _googleSignOutCubit?.signOutGoogle();
  }

  apiSignOutFacebook() {
    // Utility.showLoader(context);
    _fbSignOutCubit?.signOutWithFacebook();
  }

  Widget _imageView() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: CachedNetworkImage(
        width: 100,
        height: 100,
        imageUrl: userDto?.avatar ?? "",
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Image.asset("assets/images/user_placeholder.png"),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Image.asset("assets/images/user_placeholder.png"),
        ),
      ),
    );
  }

  getDetail() {
    _appSession.getUserDetail().then((value) => {
          setState(() {
            userDto = value;
          })
        });
  }
}
