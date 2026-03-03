import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../core/ utils/app_assets.dart';
import '../../../core/ utils/app_colors.dart';
import '../../../core/ utils/app_styles.dart';
import '../../../core/widgets/custom_main_button.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routName = "onboarding";

  OnboardingScreen({super.key});

  final GlobalKey<IntroductionScreenState> introKey =
      GlobalKey<IntroductionScreenState>();

  List<PageViewModel> getPages() {
    return [
      _buildPageModel(
        title: "onboarding.page1_title",
        body: "onboarding.page1_body",
        imagePath: OnBoardingAssets.onBoarding1,
        isFirstPage: true,
      ),
      _buildPageModel(
        title: "onboarding.page2_title",
        body: "onboarding.page2_body",
        imagePath: OnBoardingAssets.onBoarding2,
      ),
      _buildPageModel(
        title: "onboarding.page3_title",
        body: "onboarding.page3_body",
        imagePath: OnBoardingAssets.onBoarding3,
      ),
      _buildPageModel(
        title: "onboarding.page4_title",
        body: "onboarding.page4_body",
        imagePath: OnBoardingAssets.onBoarding4,
      ),
      _buildPageModel(
        title: "onboarding.page5_title",
        body: "onboarding.page5_body",
        imagePath: OnBoardingAssets.onBoarding5,
      ),
      _buildPageModel(
        title: "onboarding.page6_title",
        body: "",
        imagePath: OnBoardingAssets.onBoarding6,
        isLastPage: true,
      ),
    ];
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

          /// Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.black.withOpacity(0.4),
                  ],
                ),
              ),
            ),
          ),

          /// Bottom Content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              decoration:  BoxDecoration(
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
                    style: AppStyles.white24700,
                  ),
                  if (body.isNotEmpty) ...[
                    SizedBox(height: 15.h),
                    Text(
                      body.tr(),
                      textAlign: TextAlign.center,
                      style: AppStyles.white16400.copyWith(
                        color: AppColors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                  SizedBox(height: 30.h),
                  if (isFirstPage)
                    CustomMainButton(
                      text: "onboarding.buttons.explore_now".tr(),
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
                              ? "onboarding.buttons.finish".tr()
                              : "onboarding.buttons.next".tr(),
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
                          text: "onboarding.buttons.back".tr(),
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
