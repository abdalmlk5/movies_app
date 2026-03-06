class OnboardingPageModel {
  String title, body, imagePath;
  bool isLastPage, isFirstPage;

  OnboardingPageModel({
    required this.title,
    required this.body,
    required this.imagePath,
    this.isLastPage = false,
    this.isFirstPage = false,
  });
}
