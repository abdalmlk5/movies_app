import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_styles.dart';

class ProfileStatWidget extends StatelessWidget {
  final String label;
  final String count;

  const ProfileStatWidget({
    super.key,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(count, style: AppStyles.white24700),
        SizedBox(height: 4.h),
        Text(label, style: AppStyles.white20700),
      ],
    );
  }
}
