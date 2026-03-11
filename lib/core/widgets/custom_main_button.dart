import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_styles.dart';

class CustomMainButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final double height;
  final Color? borderColor;
  final String? prefixIcon;

  const CustomMainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 12,
    this.height = 55,
    this.borderColor,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOutlined = backgroundColor == Colors.transparent;

    return SizedBox(
      width: double.infinity,
      height: height.h,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: borderColor ?? Colors.transparent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius.r),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : _buildButtonContent(context),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    backgroundColor ?? Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius.r),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : _buildButtonContent(context),
            ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          Image.asset(
            prefixIcon!,
            height: 24.h,
            width: 24.w,
          ),
          SizedBox(width: 10.w),
        ],
        Text(
          text,
          style: (backgroundColor == Colors.transparent
                  ? AppStyles.primary20600
                  : AppStyles.black20600)
              .copyWith(
            color: textColor,
          ),
        ),
      ],
    );
  }
}
