import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';

class ProfileEmptyState extends StatelessWidget {
  const ProfileEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 60.h),
        Center(
          child: Image.asset(
            AppIcons.emptyIcon,
            height: 150.h,
            width: 150.w,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.movie, size: 100.h, color: AppColors.gray),
          ),
        ),
      ],
    );
  }
}
