import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              // حقل البحث (Search Bar)
              _buildSearchBar(),

              SizedBox(height: 25.h),

              // عنوان النتائج المقترحة
              Text(
                "Popular Searches",
                style: AppStyles.white24700.copyWith(fontSize: 18.sp),
              ),

              SizedBox(height: 15.h),

              // قائمة النتائج (مثال ثابت)
              Expanded(
                child: _buildRecentSearchList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        color: const Color(0xFF282828),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Search for movies...",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
          prefixIcon: Icon(Icons.search, color: AppColors.primary, size: 24.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.h),
        ),
      ),
    );
  }

  Widget _buildRecentSearchList() {
    // قائمة تجريبية للأفلام
    final List<String> dummyMovies = [
      "Inception",
      "Interstellar",
      "The Dark Knight",
      "Avengers: Endgame",
      "The Joker"
    ];

    return ListView.separated(
      itemCount: dummyMovies.length,
      separatorBuilder: (context, index) => Divider(color: Colors.grey.withOpacity(0.2)),
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 50.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Icon(Icons.movie, color: Colors.white),
          ),
          title: Text(
            dummyMovies[index],
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16.sp),
          onTap: () {
            // هنا هتحط الـ Logic لما يضغط على فيلم
          },
        );
      },
    );
  }
}