import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/%20utils/app_assets.dart';
import 'package:movies_app/core/%20utils/app_colors.dart';
import 'package:movies_app/core/%20utils/app_styles.dart';


class HomeScreen extends StatefulWidget {
  static const String routName = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [

          _buildBackground(),

          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),

                Center(
                  child: Image.asset(
                    AppImages.AvailableNow,


                    height: 80.h,
                  ),
                ),
                const MovieCarousel(),

                SizedBox(height: 20.h),
                // Watch Now Section
                Center(
                  child: Image.asset(

AppImages.WatchNowText,
                    height: 100.h,
                  ),
                ),

                // Category Section (Action)
                _buildCategoryRow("Action"),
                _buildHorizontalMoviesList(),

                SizedBox(height: 100.h), // مساحة للـ Bottom Bar
              ],
            ),
          ),

          // الـ Bottom Navigation Bar المخصص
          _buildCustomBottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.3,
        child: Image.asset(
          OnBoardingAssets.onBoarding1, // خلفية متغيرة حسب الفيلم
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCategoryRow(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppStyles.white24700.copyWith(fontSize: 20.sp)),
          Row(
            children: [
              Text("See More", style: TextStyle(color: AppColors.primary, fontSize: 14.sp)),
              Icon(Icons.arrow_forward, color: AppColors.primary, size: 16.sp),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalMoviesList() {
    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 16.w),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: MoviePosterCard(
              image: OnBoardingAssets.onBoarding2,
              rating: "7.7",
              width: 140.w,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomBottomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E).withOpacity(0.9),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, 0),
            _navItem(Icons.search, 1),
            _navItem(Icons.explore, 2),
            _navItem(Icons.person, 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Icon(
        icon,
        color: isSelected ? AppColors.primary : Colors.white,
        size: 28.sp,
      ),
    );
  }
}

// ويدجت الـ PageView العلوي (Carousel)
class MovieCarousel extends StatefulWidget {
  const MovieCarousel({super.key});

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  late PageController _pageController;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.6, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) => setState(() => _currentPage = value),
        itemCount: 5,
        itemBuilder: (context, index) {
          double scale = _currentPage == index ? 1.0 : 0.8;
          return TweenAnimationBuilder(
            duration: const Duration(milliseconds: 350),
            tween: Tween(begin: scale, end: scale),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: MoviePosterCard(
                  image: OnBoardingAssets.onBoarding3,
                  rating: "7.7",
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ويدجت الكارت الخاص بالفيلم مع التقييم
class MoviePosterCard extends StatelessWidget {
  final String image;
  final String rating;
  final double? width;

  const MoviePosterCard({super.key, required this.image, required this.rating, this.width});

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
            child: Image.asset(image, fit: BoxFit.cover, height: double.infinity, width: double.infinity),
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
                  Text(rating, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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