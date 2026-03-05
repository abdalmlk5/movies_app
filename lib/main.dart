import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/app_routes.dart';
import 'features/auth/presentation/views/login_view.dart';
import 'features/auth/presentation/views/register_view.dart';
import 'features/auth/presentation/views/reset_password_view.dart';
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
        initialRoute: AppRoutes.onboardingScreen,
        routes: {
          AppRoutes.onboardingScreen: (context) => OnboardingScreen(),
          AppRoutes.loginScreen: (context) => LoginView(),
          AppRoutes.registerScreen: (context) => RegisterView(),
          AppRoutes.resetPasswordScreen: (context) => ResetPasswordView(),
        },
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
