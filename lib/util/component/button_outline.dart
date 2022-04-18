import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/util/utility.dart';

import '../app_colors.dart';
import '../constants.dart';
import '../dimensions.dart';

class ButtonOutline extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double? height;
  final Color textColor;
  final Color containerColor;
  final Color border;

  const ButtonOutline(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.height = 48,
      this.textColor = AppColors.primary,
      this.containerColor = AppColors.transparent,
      this.border=AppColors.border
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.transparent ,
        border: Border.all(color: AppColors.red),
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextButton(
        onPressed: () {
          onPressed.call();
        },
        child: Text(
          Utility.capitalized(text),
          style: const TextStyle(
              color: AppColors.red,
              fontSize: Dimensions.textSizeMedium,
              fontFamily: Constants.fontFamily2,
              fontWeight: FontWeight.w500),
        ),
        style:
            TextButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
      ),
    );
  }
}
