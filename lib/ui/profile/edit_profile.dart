import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/util/component/button_fill.dart';
import 'package:flutter_firebase_ott/util/component/title_text.dart';
import '../../util/app_colors.dart';
import '../../util/component/back_button.dart';
import '../../util/component/photo_action_bottom_sheet.dart';
import '../../util/dimensions.dart';
import '../../util/strings.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String name = "";
  String email = "";
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.bgGradientBoxDecoration(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.transparent,
        body: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.textSizeMedium,
              right: Dimensions.marginMedium,
              top: MediaQuery.of(context).padding.top ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ButtonBack(),
                  // TitleText(
                  //   text: Strings.editProfile,
                  //   fontSize: Dimensions.textSizeXLarge,
                  // ),
                  ButtonFill(text: "Update", onPressed: (){})
                  // Container(
                  //   height: 40,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //     color: AppColors.containerColor,
                  //     borderRadius:
                  //     BorderRadius.circular(Dimensions.cornerRadiusMedium),
                  //   ),
                  //   child: const Center(
                  //       child: Text(
                  //         "Update",
                  //         style: TextStyle(
                  //             color: AppColors.white, fontWeight: FontWeight.w500),
                  //       )),
                  // ),
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
}
