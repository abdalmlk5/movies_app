import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';

class MovieInfoItem extends StatelessWidget {
  final String iconPath;
  final String value;

  const MovieInfoItem({
    super.key,
    required this.iconPath,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(15.r)),
      child: Row(children: [

        Image.asset(iconPath, width: 20.w, height: 20.h, color: AppColors.primary),
        SizedBox(width: 8.w),
        Text(value, style: AppStyles.white16400)
      ]),
    );
  }
}