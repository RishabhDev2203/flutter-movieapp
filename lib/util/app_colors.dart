import 'package:flutter/material.dart';

class AppColors {

  //App Colors
  static const header = Color(0xFF211340);
  static const primary = Color(0xFF105F50);
  static const primaryDark = Color(0xFF2C1A53);
  static const bg = Color(0xFF2C1A53);
  static const secondaryBg = Color(0xFF33344E);

  //Text Colors
  static const textPrimary = Color(0xFF13161E);
  static const textSecondary = Color(0xFFA8ABC3);
  static const textThird = Color(0xFFDCEAE7);
  static const textErrorColor =Color(0xFFFC264C);
  static const textPlaceHolder = Color(0xFFA8ABC3);
  static const subtitleColor =Color(0xFF495B5A);

  //Container Colors
  static const containerBg = Color(0xFFEDF9F6);
  static const containerBorder = Color(0xFFC9DFDA);
  static const containerBgOrangeColor =Color(0xFFFFFBF4);
  static const thirdContainerColor =Color(0xFFCCDCD4);
  static const checkBoxActiveColor =Color(0xFFE4F4F0);
  static const fourthContainerColor =Color(0xFFDCEDE9);
  static const fifthContainerColor =Color(0xFFEFF4F3);
  static const sixthContainerColor =Color(0xFFD9E9E5);
  static const pinkContainerColor =Color(0xFFFFEFF2);
  static const pinkBorderColor =Color(0xFFF7DEE2);
  static const pinkColor =Color(0xFFFC3055);
  static const containerColor =Color(0xFF1F2845);

  //Divider Colors
  static const divider = Color(0xFF443E60);
  static const dividerSecondary = Color(0xFFE5E5EA);
  static const border = Color(0xFFA9BCB9);

  //Icon Colors
  static const iconColor =Color(0xFFE15923);
  static const iconPrimaryColor =Color(0xFFE4F4F0);
  static const iconSecondaryColor =Color(0xFF9AA6A3);

  //Common Colors
  static const transparent = Colors.transparent;
  static const error = Color(0xFFF4603F);
  static const red = Color(0xFFF43F5A);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const backButtonColor = Color(0xFFEDFAF7);
  static const secondaryContainerColor=Color(0xFFEDDFB7);
  static const orange=Color(0xFFFF8F3F);
  static const maroonColor =Color(0xFF603050);
  static const checkboxColor =Color(0xFFE2F1EE);
  static const yellowColor =Color(0xFFDD9406);
  static const borderYellowColor =Color(0xFFD29639);
  static const textColor =Color(0xFF1A1817);
  static const shimmerBase = Color(0xFFE4F4F0);
  static const shimmerAnim = Colors.white70;


  // Gradient Color
  static buttonGradient() {
    return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF65FFDE), Color(0xFF1690D1)]
        );
  }

  static bgGradientBoxDecoration() {
    return  const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [-1,0.6],
          colors: [Color(0xFF33344E),Color(0xFF18182F)]
      ),
    );
  }

  static buttonGradientLight() {
    return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE0FFF8), Color(0xFFD0E9F6)]);
  }

  static Widget gradientOverlay(double h, double w, double cornerRadius) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cornerRadius),
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: const [-1, 0.2, 0.7],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.transparent,
            Colors.transparent,
            Colors.black.withOpacity(0.8),
          ],
        ),
      ),
    );
  }

  static bgContainerBoxDecoration() {
    return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFCE6E6),Color(0xFFFFF6F6)]
      );
  }

  static bgSecondaryContainerBoxDecoration() {
    return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFCFFEE),Color(0xFFFFFFFF)]
      );
  }
}
