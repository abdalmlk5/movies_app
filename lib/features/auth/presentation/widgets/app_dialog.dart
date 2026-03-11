import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';

class AppDialog extends StatelessWidget {
  final String title, content;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final List<Widget> actions;

  const AppDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
    this.titleStyle,
    this.contentStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: titleStyle ?? AppStyles.white16400,
      ),
      content: Text(
        content,
        style: contentStyle ?? AppStyles.white14400,
      ),
      actions: actions,
    );
  }
}
