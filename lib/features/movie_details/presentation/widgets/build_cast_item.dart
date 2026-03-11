import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';

class CastItem extends StatelessWidget {
  final String name;
  final String character;
  final String? imageUrl;

  const CastItem({
    super.key,
    required this.name,
    required this.character,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: imageUrl != null
                ? Image.network(
              imageUrl!,
              width: 60.w,
              height: 60.h,
              fit: BoxFit.cover,
            )
                : Container(
              width: 60.w,
              height: 60.h,
              color: Colors.grey,
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name : $name",
                  style: AppStyles.white14400,
                ),
                Text(
                  "Character : $character",
                  style: AppStyles.white14400.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}