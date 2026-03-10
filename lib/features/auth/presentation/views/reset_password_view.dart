import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/config/validations/app_validations.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_main_button.dart';
import 'package:movies_app/core/widgets/custom_main_text_form_field.dart';
import 'package:movies_app/features/auth/presentation/widgets/app_dialog.dart';

import '../../../../config/di/di.dart';
import '../view_model/auth_bloc.dart';
import '../view_model/auth_events.dart';
import '../view_model/auth_state.dart';

class ResetPasswordView extends StatelessWidget {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.resetPassword.tr(),
              style: AppStyles.primary20600),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h),
                    Image.asset(
                      AppImages.forgetPasswordImage,
                      height: 350.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 40.h),
                    CustomMainTextFormField(
                      hintText: AppStrings.email.tr(),
                      prefixIcon: AppIcons.emailIcon,
                      controller: emailController,
                      validator: (value) => AppValidations.validateEmail(value),
                    ),
                    SizedBox(height: 30.h),
                    BlocConsumer<AuthBloc, AuthState>(
                      listenWhen: (previous, current) =>
                          previous.resetPasswordState !=
                          current.resetPasswordState,
                      listener: (context, state) {
                        if (state.resetPasswordState.errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text(state.resetPasswordState.errorMessage!),
                            ),
                          );
                        }
                        if (state.resetPasswordState.data != null) {
                          print("data: ${state.resetPasswordState.data}");
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AppDialog(
                                title: state.resetPasswordState.data ?? '',
                                content: "check_your_email".tr(),
                                actions: <Widget>[
                                  CustomMainButton(
                                      text: 'go_to_login_screen'.tr(),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      }),
                                ],
                              );
                            },
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomMainButton(
                            text: AppStrings.verifyEmail.tr(),
                            onPressed:
                                // Logic to create account
                                state.resetPasswordState.isLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<AuthBloc>().add(
                                                ResetPasswordEvent(
                                                  emailController.text,
                                                ),
                                              );
                                        }
                                      });
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
