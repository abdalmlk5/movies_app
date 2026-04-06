import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';

class ProfileSectionButton extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;
  final String iconPath;
  final VoidCallback onTap;

  const ProfileSectionButton({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    iconPath,
                    height: 35.h,
                    width: 35.w,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 8.w),
                  Text(title, style: AppStyles.white20400),
                ],
              ),
            ),
            if (isSelected)
              Container(
                height: 3.h,
                color: AppColors.primary,
              )
            else
              SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
