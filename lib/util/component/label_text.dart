import 'package:flutter/cupertino.dart';

import '../app_colors.dart';
import '../dimensions.dart';

class LabelText extends StatelessWidget {
  final String text;
  final double fontSize;

  const LabelText(
      {Key? key, required this.text, this.fontSize = Dimensions.textSizeLarge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: fontSize,
          fontWeight: FontWeight.w400),
    );
  }
}
