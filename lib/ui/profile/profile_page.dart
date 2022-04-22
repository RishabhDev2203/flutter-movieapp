import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_firebase_ott/util/app_colors.dart';
import 'package:flutter_firebase_ott/util/component/back_button.dart';
import 'package:flutter_firebase_ott/util/component/my_container.dart';
import 'package:flutter_firebase_ott/util/dimensions.dart';
import 'package:flutter_firebase_ott/util/strings.dart';
import '../../util/component/photo_action_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../util/constants.dart';
import '../auth/create_new_password.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.bgGradientBoxDecoration(),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top+30,left: Dimensions.marginMedium,right: Dimensions.marginMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ButtonBack(),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
                    },
                    child: Container(
                      height: 35,
                      width: 90,
                      decoration: BoxDecoration(
                      color: AppColors.containerColor,
                      // border: Border.all(color: AppColors.containerBorder),
                      borderRadius: BorderRadius.circular(Dimensions.cornerRadiusMedium),
                    ),
                      child: const Center(child: Text("Edit Profile",style: TextStyle(color: AppColors.white,fontWeight: FontWeight.w500),)),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50,),
              Stack(
                children: [
                  _imageView(_imagePath),
                  GestureDetector(
                    onTap: () {
                      PhotoActionBottomSheet(
                          context: context,
                          onComplete: (imagePath) {
                            _imagePath = imagePath;
                            setState(() {});
                          },
                          cropEnable: true);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(left: 45, top: 45),
                      decoration: BoxDecoration(
                          color: AppColors.containerColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          "assets/images/edit.png",
                          color: AppColors.red,
                          height: 15,
                          width: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              const Text(
                "Wade Warren",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: Dimensions.textSizeMedium,
                    fontFamily: Constants.fontFamily,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 5,),
              const Text(
                "Rennyroy@gmail.com",
                style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: Dimensions.textSizeSmall,
                    fontFamily: Constants.fontFamily,
                    fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.only(left: 16,right: 16),
                child: Divider(
                  color: AppColors.divider,thickness: 1,),
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.only(top: 25,bottom: 25,left: 10,right: 10),
                  decoration: BoxDecoration(
                    color: AppColors.myContainerColor,
                    borderRadius: BorderRadius.circular(Dimensions.cornerRadiusMedium),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                 CreateNewPasswordScreen(title: Strings.changePassword),
                              ));
                        },
                        child: Row(
                          children: [
                            const SizedBox(width: 20,),
                            Image.asset(
                              "assets/images/lock.png",
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(width: 20,),
                            const Text(
                              "Change Password",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: Dimensions.textSizeMedium,
                                  fontFamily: Constants.fontFamily,
                                  fontWeight: FontWeight.w500
                              ),
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Divider(
                        color: AppColors.black,thickness: 1.3,),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const SizedBox(width: 20,),
                          Image.asset(
                            "assets/images/logout.png",
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 20,),
                          const Text(
                            "Logout",
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: Dimensions.textSizeMedium,
                                fontFamily: Constants.fontFamily,
                                fontWeight: FontWeight.w500
                            ),
                          ),

                        ],
                      )
                    ],
                  )
              )


            ],
          ),
        ),
      ),
    );
  }

  Widget _imageView(String? imagePath) {
    return imagePath == null
        ? ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: CachedNetworkImage(
        width: 70,
        height: 70,
        imageUrl: "",
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Image.asset("assets/images/user_placeholder.png"),
            ),
        errorWidget: (context, url, error) =>
            Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Image.asset("assets/images/user_placeholder.png"),
            ),
      ),
    )
        : ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.file(File(imagePath),
          fit: BoxFit.cover,
          height: 100,
          width: 100),
    );
  }
}
