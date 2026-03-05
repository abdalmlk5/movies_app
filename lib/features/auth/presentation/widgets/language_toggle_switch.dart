import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class LanguageToggleSwitch extends StatelessWidget {
  const LanguageToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<Locale>.dual(
      current: context.locale,
      first: const Locale('en'),
      second: const Locale('ar'),
      spacing: 2.w,
      style: const ToggleStyle(
        borderColor: AppColors.primary,
        indicatorColor: AppColors.primary,
      ),
      borderWidth: 1.0,
      height: 40.h,
      //context.setLocale(const Locale('ar'));
      onChanged: (locale) => context.setLocale(locale),
      iconBuilder: (value) => value.languageCode == 'en'
          ? Image.asset(AppIcons.usFlagIcon)
          : Image.asset(AppIcons.egFlagIcon),
      textBuilder: (value) => value.languageCode == 'en'
          ? const Center(child: Text('EN'))
          : const Center(child: Text('AR')),
    );
  }
}
