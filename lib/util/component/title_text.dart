import 'package:flutter/cupertino.dart';

import '../app_colors.dart';
import '../dimensions.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;

  const TitleText(
      {Key? key, required this.text, this.fontSize = Dimensions.textSizeXLarge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: AppColors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w500),
    );
  }
}
