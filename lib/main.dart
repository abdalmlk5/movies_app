import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/home/presentation/view/home_screen.dart';
import 'package:movies_app/features/movie_details/presentation/views/MovieDetailsScreen.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/presentation/views/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        // يفضل البدء بـ OnboardingScreen لو أول مرة أو HomeScreen مباشرة
        initialRoute: HomeScreen.routName,
        routes: {
          OnboardingScreen.routName: (context) => const OnboardingScreen(),
          HomeScreen.routName: (context) => const HomeScreen(),
          // تم حذف MovieDetailsScreen من هنا لأنها تحتاجmovieId
        },
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: darkTheme, // تأكد من استيراد الثيم بشكل صحيح
        themeMode: ThemeMode.dark,
      ),
    );
  }
}