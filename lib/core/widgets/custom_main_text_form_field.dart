import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomMainTextFormField extends StatelessWidget {
  final String hintText, prefixIcon;
  final int borderRadius;
  final Color backgroundColor;
  final TextEditingController controller;
  final bool? isSecure;

  const CustomMainTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.borderRadius = 15,
    required this.controller,
    this.isSecure,
    this.backgroundColor = AppColors.gray,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppStyles.white20400,
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor,
        hintText: hintText,
        hintStyle: AppStyles.white16400,
        prefixIcon: Image.asset(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
