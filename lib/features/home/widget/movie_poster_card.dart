import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:movies_app/core/utils/app_styles.dart';

class MoviePosterCard extends StatelessWidget {
  final String imageUrl;
  final String rating;
  final double? width;

  const MoviePosterCard(
      {super.key, required this.imageUrl, required this.rating, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, color: Colors.white),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Text(
                    rating,
                    style: AppStyles.white14400,
                  ),
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}