import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:movies_app/core/utils/app_strings.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_main_button.dart';
import '../models/get_models.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routName = "onboarding";

  OnboardingScreen({super.key});

  final GlobalKey<IntroductionScreenState> introKey =
      GlobalKey<IntroductionScreenState>();

  List<PageViewModel> getPages() {
    return getModels().map(
      (model) {
        return _buildPageModel(
          title: model.title,
          body: model.body,
          imagePath: model.imagePath,
          isFirstPage: model.isFirstPage,
          isLastPage: model.isLastPage,
        );
      },
    ).toList();
  }

  PageViewModel _buildPageModel({
    required String title,
    required String body,
    required String imagePath,
    bool isFirstPage = false,
    bool isLastPage = false,
  }) {
    return PageViewModel(
      title: "",
      body: "",
      image: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title.tr(),
                    textAlign: TextAlign.center,
                    style: isFirstPage
                        ? AppStyles.white36500
                        : AppStyles.white24700,
                  ),
                  if (body.isNotEmpty) ...[
                    SizedBox(height: 15.h),
                    Text(body.tr(),
                        textAlign: TextAlign.center,
                        style: AppStyles.white20400),
                  ],
                  SizedBox(height: 30.h),
                  if (isFirstPage)
                    CustomMainButton(
                      text: AppStrings.exploreNow.tr(),
                      onPressed: () => introKey.currentState?.next(),
                      borderRadius: 16.r,
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.black,
                    )
                  else
                    Column(
                      children: [
                        CustomMainButton(
                          text: isLastPage
                              ? AppStrings.finish.tr()
                              : AppStrings.next.tr(),
                          onPressed: () {
                            if (isLastPage) {
                            } else {
                              introKey.currentState?.next();
                            }
                          },
                          borderRadius: 16.r,
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.black,
                        ),
                        SizedBox(height: 12.h),
                        CustomMainButton(
                          text: AppStrings.back.tr(),
                          onPressed: () => introKey.currentState?.previous(),
                          borderRadius: 16.r,
                          backgroundColor: Colors.transparent,
                          textColor: AppColors.primary,
                          borderColor: AppColors.primary,
                        ),
                      ],
                    ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
      decoration: const PageDecoration(
        fullScreen: true,
        contentMargin: EdgeInsets.zero,
        imagePadding: EdgeInsets.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: IntroductionScreen(
        key: introKey,
        pages: getPages(),
        showBackButton: false,
        showNextButton: false,
        showDoneButton: false,
        showSkipButton: false,
        isProgress: false,
      ),
    );
  }
}
