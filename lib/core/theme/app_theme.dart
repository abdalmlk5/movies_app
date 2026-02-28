import 'package:flutter/material.dart';

import '../ utils/app_colors.dart';

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.black,
  primaryColor: AppColors.primary,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.black,
    elevation: 0,
    centerTitle: true,
  ),
);
