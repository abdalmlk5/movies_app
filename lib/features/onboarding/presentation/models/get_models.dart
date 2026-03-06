import 'package:movies_app/features/onboarding/presentation/models/onboarding_page_model.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';

List<OnboardingPageModel> getModels() {
  return [
    OnboardingPageModel(
        title: AppStrings.onboardingTitle1,
        body: AppStrings.onboardingBody1,
        imagePath: OnBoardingAssets.onBoarding1,
        isFirstPage: true),
    OnboardingPageModel(
        title: AppStrings.onboardingTitle2,
        body: AppStrings.onboardingBody2,
        imagePath: OnBoardingAssets.onBoarding2),
    OnboardingPageModel(
        title: AppStrings.onboardingTitle3,
        body: AppStrings.onboardingBody3,
        imagePath: OnBoardingAssets.onBoarding3),
    OnboardingPageModel(
        title: AppStrings.onboardingTitle4,
        body: AppStrings.onboardingBody4,
        imagePath: OnBoardingAssets.onBoarding4),
    OnboardingPageModel(
        title: AppStrings.onboardingTitle5,
        body: AppStrings.onboardingBody5,
        imagePath: OnBoardingAssets.onBoarding5),
    OnboardingPageModel(
        title: AppStrings.onboardingTitle6,
        body: AppStrings.onboardingBody6,
        imagePath: OnBoardingAssets.onBoarding6,
        isLastPage: true),
  ];
}
