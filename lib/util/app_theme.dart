import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0xFF1F113E);
  static const primaryDarkColor = Color(0xFF2C1A53);
  static const primaryAssentColor = Color(0xFF808080);

  static const erroColor = Color(0xFF808080);
  static final light = ThemeData(
      brightness: Brightness.light,
      accentColor: Colors.red,
      disabledColor: Colors.grey.shade400,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      backgroundColor: Colors.white,
      primarySwatch: createMaterialColor(AppTheme.primaryColor));

  static final dark = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.red,
    disabledColor: Colors.grey.shade400,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    backgroundColor: Colors.black12,
  );

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
