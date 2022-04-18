import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../dimensions.dart';

class MyContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;

  const MyContainer({Key? key, required this.child, this.padding, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: Dimensions.marginMedium),
      decoration: BoxDecoration(
        color: color ?? AppColors.divider,
        // border: Border.all(color: AppColors.containerBorder),
        borderRadius: BorderRadius.circular(Dimensions.cornerRadiusMedium),
      ),
      child: child,
    );
  }
}
