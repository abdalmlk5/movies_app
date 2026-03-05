import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_main_button.dart';
import 'package:movies_app/core/widgets/custom_main_text_form_field.dart';

class ResetPasswordView extends StatelessWidget {
  final emailController = TextEditingController();

  ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppStrings.resetPassword.tr(), style: AppStyles.primary20600),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                Image.asset(
                  AppImages.forgetPasswordImage,
                  height: 350.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 40.h),
                CustomMainTextFormField(
                  hintText: AppStrings.email.tr(),
                  prefixIcon: AppIcons.emailIcon,
                  controller: emailController,
                ),
                SizedBox(height: 30.h),
                CustomMainButton(
                  text: AppStrings.verifyEmail.tr(),
                  onPressed: () {
                    // Logic to verify email
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
