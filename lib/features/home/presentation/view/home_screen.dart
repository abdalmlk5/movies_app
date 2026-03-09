import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/features/home/browse_tab/presentation/views/ExploreTab.dart';
import 'package:movies_app/features/home/home_tab/presentation/views/MainHome.dart';
import 'package:movies_app/features/home/profile_tab/presentation/views/ProfileTab.dart';
import 'package:movies_app/features/home/search_tab/presentation/views/SearchTab.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const MainHomeTab(),
    const SearchTab(),
    const ExploreTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          _tabs[_selectedIndex],
          _buildCustomBottomNavBar(),
        ],
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