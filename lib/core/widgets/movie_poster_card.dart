import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';

class MoviePosterCard extends StatelessWidget {
  final String imageUrl;
  final String rating;
  final double? width;
  final double? height;
  final double borderRadius;

  const MoviePosterCard({
    super.key,
    required this.imageUrl,
    required this.rating,
    this.width,
    this.height,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.white.withAlpha(12),
                child: Center(
                  child: Icon(Icons.broken_image,
                      color: AppColors.white, size: 32.r),
                ),
              ),
            ),
            Positioned(
              top: 10.h,
              left: 10.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(127),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Text(rating, style: AppStyles.white16400),
                    SizedBox(width: 4.w),
                    const Icon(Icons.star, color: AppColors.primary, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
