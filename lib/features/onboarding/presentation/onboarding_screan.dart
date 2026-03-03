import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../core/ utils/app_assets.dart';
import '../../../core/ utils/app_colors.dart';
import '../../../core/ utils/app_styles.dart';


class OnboardingScreen extends StatefulWidget {
  static const String routName = "Intro";

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final GlobalKey<IntroductionScreenState> introKey =
  GlobalKey<IntroductionScreenState>();

  List<PageViewModel> getPages() {
    return [
      _buildPageModel(
        title: "Find Your Next Favorite Movie Here",
        body:
        "Get access to a huge library of movies to suit all tastes. You will surely like it.",
        imagePath: OnBoardingAssets.onBoarding1,
        isFirstPage: true,
      ),
      _buildPageModel(
        title: "Discover Movies",
        body:
        "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
        imagePath: OnBoardingAssets.onBoarding2,
      ),
      _buildPageModel(
        title: "Explore All Genres",
        body:
        "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
        imagePath: OnBoardingAssets.onBoarding3,
      ),
      _buildPageModel(
        title: "Create Watchlists",
        body:
        "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
        imagePath: OnBoardingAssets.onBoarding4,
      ),
      _buildPageModel(
        title: "Rate, Review, and Learn",
        body:
        "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews",
        imagePath: OnBoardingAssets.onBoarding5,
      ),
      _buildPageModel(
        title: "Start Watching Now",
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
              padding:
              EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              decoration: const BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
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
                  SizedBox(height: 15.h),
                  Text(
                    body.tr(),
                    textAlign: TextAlign.center,
                    style: AppStyles.white16400.copyWith(
                      color: AppColors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  if (isFirstPage)
                    _buildButton(
                      text: "Explore Now",
                      onPressed: () =>
                          introKey.currentState?.next(),
                      isFilled: true,
                    )
                  else
                    Column(
                      children: [
                        _buildButton(
                          text: isLastPage ? "Finish" : "Next",
                          onPressed: () {
                            if (isLastPage) {

                            } else {
                              introKey.currentState?.next();
                            }
                          },
                          isFilled: true,
                        ),
                        SizedBox(height: 12.h),
                        _buildButton(
                          text: "Back",
                          onPressed: () =>
                              introKey.currentState?.previous(),
                          isFilled: false,
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

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    bool isFilled = true,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: isFilled
          ? ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          text.tr(),
          style: AppStyles.black20600,
        ),
      )
          : OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          text.tr(),
          style: AppStyles.primary20600,
        ),
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