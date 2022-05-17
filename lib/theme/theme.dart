import 'package:flutter/material.dart';

part 'color_schemes.dart';

class Themes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
  );
}
