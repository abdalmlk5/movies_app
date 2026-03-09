import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة تجريبية للتصنيفات
    final List<Map<String, dynamic>> categories = [
      {"name": "Action", "icon": Icons.local_fire_department},
      {"name": "Adventure", "icon": Icons.explore},
      {"name": "Comedy", "icon": Icons.emoji_emotions},
      {"name": "Drama", "icon": Icons.theater_comedy},
      {"name": "Horror", "icon": Icons.scuba_diving}, // أو أي أيقونة مناسبة
      {"name": "Sci-Fi", "icon": Icons.rocket_launch},
      {"name": "Animation", "icon": Icons.animation},
      {"name": "Romance", "icon": Icons.favorite},
    ];

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "Explore Categories",
                style: AppStyles.white24700.copyWith(fontSize: 22.sp),
              ),
              SizedBox(height: 20.h),

              // شبكة التصنيفات
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // عمودين
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                    childAspectRatio: 1.5, // لضبط شكل الكارت
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return _buildCategoryCard(
                      categories[index]["name"],
                      categories[index]["icon"],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String name, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF282828),
            const Color(0xFF1A1A1A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primary, size: 30.sp),
          SizedBox(height: 10.h),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}