import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_styles.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            // صورة البروفايل واسم المستخدم
            _buildProfileHeader(),

            SizedBox(height: 30.h),

            // قائمة الإعدادات
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 20.h),
                    _buildProfileItem(Icons.person_outline, "Edit Profile"),
                    _buildProfileItem(Icons.favorite_border, "My Wishlist"),
                    _buildProfileItem(Icons.settings_outlined, "Settings"),
                    _buildProfileItem(Icons.help_outline, "Help & Support"),
                    const Divider(color: Colors.white10),
                    _buildProfileItem(Icons.logout, "Logout", isLogout: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 60.r,
          backgroundColor: AppColors.primary,
          child: CircleAvatar(
            radius: 56.r,
            //backgroundImage: const AssetImage(AppImages.avatar_1), // استخدم أي Avatar عندك
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          "Eslam Trekay", // اسمك يا بطل
          style: AppStyles.white24700.copyWith(fontSize: 22.sp),
        ),
        Text(
          "trekasayed123@gmail.com", // إيميلك المكتوب في Git
          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildProfileItem(IconData icon, String title, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : AppColors.primary),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: isLogout
          ? null
          : Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16.sp),
      onTap: () {
        // الـ Logic بتاع الضغط هنا
      },
    );
  }
}