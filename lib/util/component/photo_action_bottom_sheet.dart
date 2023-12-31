import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../locale/application_localizations.dart';
import '../app_colors.dart';
import '../dimensions.dart';
import 'my_container.dart';

class PhotoActionBottomSheet {
  final Function(String) onComplete;
  final BuildContext context;
  bool cropEnable;

  PhotoActionBottomSheet(
      {required this.context,
      required this.onComplete,
      this.cropEnable = false}) {
    _showModalBottomSheet(context);
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)),
        ),
        isScrollControlled: true,
        backgroundColor: AppColors.containerBg,
        context: context,
        builder: (_) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
            child: Container(
              padding: const EdgeInsets.only(
                  left: Dimensions.marginMedium,
                  right: Dimensions.marginMedium,
                  top: 10,
                 /*  bottom: Dimensions.textSizeMedium*/),
              // decoration: AppColors.bgGradientBoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(8)),
                        color: AppColors.containerBorder),
                  ),
                  const SizedBox(height: 20),
                   Text(
                      ApplicationLocalizations.of(context)!.translate("chooseAnAction")!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.containerBorder,
                        fontSize: Dimensions.textSizeMedium,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  MyContainer(
                    padding: EdgeInsets.zero,
                    child: TextButton.icon(
                      label:  Text(ApplicationLocalizations.of(context)!.translate("takePhoto")!,),
                      icon: const Icon(
                        Icons.photo_camera_outlined,
                        color: AppColors.white,
                        size: 24.0,
                      ),
                      onPressed: () {
                        _openCamera();
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                              left: Dimensions.marginMedium),
                          backgroundColor: AppColors.navyBlueContainerColor,
                          primary: AppColors.white,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8),
                          )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyContainer(
                    padding: EdgeInsets.zero,
                    child: TextButton.icon(
                      label:  Text(ApplicationLocalizations.of(context)!.translate("chooseFromGallery")!,),
                      icon: const Icon(
                        Icons.photo_library_outlined,
                        color: AppColors.white,
                        size: 24.0,
                      ),
                      onPressed: () {
                        _openGallery();
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                              left: Dimensions.marginMedium),
                          backgroundColor: AppColors.navyBlueContainerColor,
                          primary: AppColors.white,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8),
                          )),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          );
        });
  }

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
    onComplete.call(_imageFileList![0].path);
  }

  List<File>? _imageFileCropList;

  set _imageCropFile(File? value) {
    _imageFileCropList = value == null ? null : [value];
    onComplete.call(_imageFileCropList![0].path);
  }

  Future<void> _openGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (cropEnable) {
        File? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile!.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
          ],
          androidUiSettings: const AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: AppColors.black,
              toolbarWidgetColor: Colors.white,
              activeControlsWidgetColor: AppColors.black,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
              hideBottomControls: true,
              backgroundColor: AppColors.black),
          iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        );
        _imageCropFile = croppedFile;
      }
      else {
        _imageFile = pickedFile;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _openCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (cropEnable) {
        File? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile!.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
          ],
          androidUiSettings: const AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: AppColors.black,
              toolbarWidgetColor: Colors.white,
              activeControlsWidgetColor: AppColors.black,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
              hideBottomControls: true,
              backgroundColor: AppColors.black),
          iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        );
        _imageCropFile = croppedFile;
      } else {
        _imageFile = pickedFile;
      }
    } catch (e) {
      print(e);
    }
  }
}
