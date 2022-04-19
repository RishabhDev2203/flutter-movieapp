import 'package:flutter/material.dart';
import 'package:flutter_firebase_ott/util/utility.dart';
import '../app_colors.dart';
import '../constants.dart';
import '../dimensions.dart';

class ButtonFill extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double? height;
  final Color textColor;

  const ButtonFill(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.height = 45,
      this.textColor = AppColors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.buttonRedColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextButton(
        onPressed: () {
          onPressed.call();
        },
        child: FittedBox(
          child: Text(
            Utility.capitalized(text),
            style: TextStyle(
                color: textColor,
                fontSize: Dimensions.textSizeMedium,
                fontFamily: Constants.fontFamily2,
                fontWeight: FontWeight.w600),
          ),
        ),
        style:
            TextButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
      ),
    );
  }
}
