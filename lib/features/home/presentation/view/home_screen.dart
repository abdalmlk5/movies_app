import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/features/home/home_tab/presentation/views/MainHome.dart';
import 'package:movies_app/features/home/presentation/widget/custom_bottom_nav_bar.dart';
import 'package:movies_app/features/home/search_tab/presentation/views/SearchTab.dart';

import '../../profile_tab/presentation/views/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const MainHomeTab(),
    const SearchTab(),
    const ProfileTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          _tabs[_selectedIndex],
          CustomBottomNavBar(
            selectedIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}
