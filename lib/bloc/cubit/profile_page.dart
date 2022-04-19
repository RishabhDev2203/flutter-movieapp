import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_firebase_ott/util/app_colors.dart';
import 'package:flutter_firebase_ott/util/dimensions.dart';
import '../../util/component/photo_action_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
              const Align(
                alignment: Alignment.topLeft,
                  child: BackButton()),
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
              const Text(
                "Wade Warren",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: Dimensions.textSizeMedium,
                  fontWeight: FontWeight.w500
                ),
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
