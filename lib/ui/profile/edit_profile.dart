import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ideal_ott_api/dto/user_dto.dart';
import 'package:flutter_ideal_ott_api/repository/auth_repository.dart';
import 'package:flutter_ideal_ott_api/util/main_utility.dart';

import '../../bloc/api_resp_state.dart';
import '../../bloc/cubit/auth_cubit.dart';
import '../../bloc/cubit/home_cubit.dart';
import '../../util/app_colors.dart';
import '../../util/app_session.dart';
import '../../util/component/back_button.dart';
import '../../util/component/photo_action_bottom_sheet.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';
import '../../util/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String name = "";
  String email = "";
  String? _imagePath;
  final AppSession _appSession = AppSession();
  UserDto? userDto;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String? profilePicture = "";
  AuthCubit? _authCubit;

  @override
  void initState() {
    _authCubit = AuthCubit(AuthRepository());
    _appSession.init().then((value) => getDetail());
    super.initState();
  }

  @override
  void dispose() {
    _authCubit?.close();
    _authCubit = null;
    super.dispose();
  }

  _hideKeyboard() {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
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
                _hideKeyboard();
                Utility.showAlertDialog(context, "Profile update successfully.");
              }
            },
          ),
        ],
        child: Container(
          decoration: AppColors.bgGradientBoxDecoration(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.transparent,
            body: _getBody(),
          ),
        )
    );
  }

  _getBody(){
    return Padding(
      padding: EdgeInsets.only(
          left: Dimensions.textSizeMedium,
          right: Dimensions.marginMedium,
          top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ButtonBack(),
              // ButtonFill(text: "Update", onPressed: (){})
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () {
                    update();
                  },
                  child: Container(
                    height: 36,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(
                          Dimensions.cornerRadiusMedium),
                    ),
                    child: const Center(
                        child: Text(
                          "Update",
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Stack(
            children: [
              _imageView(_imagePath),
              GestureDetector(
                onTap: () {
                  PhotoActionBottomSheet(
                      context: context,
                      onComplete: (imagePath) async {
                        _imagePath = imagePath;
                        Utility.showLoader(context);
                        profilePicture = await MainUtility.uploadImage(imagePath);
                        print("profilePicture>>>>>>>>>>>>>>>>>>>>>>>> $profilePicture");
                        Utility.hideLoader(context);
                        setState(() {});
                      },
                      cropEnable: true);
                },
                child: Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.only(left: 70, top: 70),
                  decoration: BoxDecoration(
                      color: AppColors.containerColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      "assets/images/edit.png",
                      color: AppColors.red,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              // border: Border.all(color: AppColors.containerBorder),
              borderRadius:
              BorderRadius.circular(Dimensions.cornerRadiusMedium),
            ),
            child: TextField(
              controller: _nameController,
              textAlignVertical: TextAlignVertical.center,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: Strings.editName,
                prefixIcon: IconButton(
                  icon: Image.asset(
                    "assets/images/profile.png",
                    color: AppColors.white,
                    height: 20,
                    width: 20,
                  ),
                  onPressed: null,
                ),
                hintStyle: const TextStyle(
                    color: AppColors.white,
                    fontSize: Dimensions.textSizeMedium,
                    fontWeight: FontWeight.w500),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                  fontSize: Dimensions.textSizeMedium,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white),
              onChanged: (text) {
                name = text;
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              // border: Border.all(color: AppColors.containerBorder),
              borderRadius:
              BorderRadius.circular(Dimensions.cornerRadiusMedium),
            ),
            child: TextField(
              controller: _emailController,
              textAlignVertical: TextAlignVertical.center,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: Strings.editEmail,
                prefixIcon: IconButton(
                  icon: Image.asset(
                    "assets/images/sms.png",
                    color: AppColors.white,
                    height: 20,
                    width: 20,
                  ),
                  onPressed: null,
                ),
                hintStyle: const TextStyle(
                    color: AppColors.white,
                    fontSize: Dimensions.textSizeMedium,
                    fontWeight: FontWeight.w500),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                  fontSize: Dimensions.textSizeMedium,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white),
              onChanged: (text) {
                email = text;
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _imageView(String? imagePath) {
    return imagePath == null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              width: 100,
              height: 100,
              imageUrl: profilePicture ?? "",
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
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.file(File(imagePath),
                fit: BoxFit.cover, height: 100, width: 100),
          );
  }

  getDetail() {
    _appSession.getUserDetail().then((value) => {
          setState(() {
            userDto = value;
            _nameController.text = userDto?.name ?? "";
            _emailController.text = userDto?.email ?? "";
            profilePicture = userDto?.avatar ?? "";
          })
        });
  }


  void update() {
    Utility.showLoader(context);
    Map<String, Object?> data = {
      "avatar" : profilePicture,
      "name": _nameController.text,
      "email": _emailController.text,
      "updatedAt": Timestamp.now()
    };
    Future.delayed(const Duration(seconds: 1), () {
      _authCubit?.update(data);
    });
  }


}
