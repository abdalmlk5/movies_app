import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:movies_app/core/utils/app_styles.dart';

class CategoryRow extends StatelessWidget {
  final String title;

  const CategoryRow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppStyles.white20700),
          Row(
            children: [
              Text("See More", style: AppStyles.primary14400),
              const Icon(Icons.arrow_forward, color: Color(0xffF2C94C), size: 16),
            ],
          ),
        ],
      ),
    );
  }
}