import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract class AppStyles {
  // White Styles
  static TextStyle white36500 = GoogleFonts.inter(
    fontSize: 36.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static TextStyle white24700 = GoogleFonts.inter(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle white20700 = GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle white20400 = GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static TextStyle white16400 = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static TextStyle white14400 = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  // Black Styles
  static TextStyle black20600 = GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle black20400 = GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  // Primary Styles
  static TextStyle primary20600 = GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle primary16400 = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );

  static TextStyle primary14900 = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w900,
    color: AppColors.primary,
  );

  static TextStyle primary14400 = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );
}
