
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/util/component/title_text.dart';
import '../../util/app_colors.dart';
import '../../util/component/back_button.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.bgGradientBoxDecoration(),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.textSizeMedium,
              right: Dimensions.marginMedium,
              top: MediaQuery.of(context).padding.top+30),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ButtonBack(),
                  TitleText(text: Strings.editProfile,fontSize: Dimensions.textSizeXLarge,),
                  SizedBox(height: 32,width: 32,)
                ],
              ),
              const SizedBox(height: 100,),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  // border: Border.all(color: AppColors.containerBorder),
                  borderRadius: BorderRadius.circular(Dimensions.cornerRadiusMedium),
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
              const SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  // border: Border.all(color: AppColors.containerBorder),
                  borderRadius: BorderRadius.circular(Dimensions.cornerRadiusMedium),
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
              ),const SizedBox(height: 50,),
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  // border: Border.all(color: AppColors.containerBorder),
                  borderRadius: BorderRadius.circular(Dimensions.cornerRadiusMedium),
                ),
                child: const Center(child: Text("Save Details",style: TextStyle(color: AppColors.white,fontWeight: FontWeight.w500),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}