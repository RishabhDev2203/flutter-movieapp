import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../constants.dart';
import '../dimensions.dart';

class SubTitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;


  const SubTitleText(
      {Key? key, required this.text, this.fontSize = Dimensions.textSizeMedium, this.color = AppColors.black,this.fontWeight = FontWeight.w400})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: Constants.fontFamily2,
          fontWeight: fontWeight),
    );
  }
}
