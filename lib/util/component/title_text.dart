import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../dimensions.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;

  const TitleText(
      {Key? key, required this.text, this.fontSize = 28})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:Theme.of(context).textTheme.headline1

    );
  }
}
