import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
