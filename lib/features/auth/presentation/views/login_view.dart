import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_main_button.dart';
import 'package:movies_app/core/widgets/custom_main_text_form_field.dart';
import 'package:movies_app/features/auth/presentation/view_model/auth_bloc.dart';
import 'package:movies_app/features/auth/presentation/view_model/auth_state.dart';

import '../../../../config/di/di.dart';
import '../../../../config/validations/app_validations.dart';
import '../../../../core/utils/app_routes.dart';
import '../../domain/models/app_user.dart';
import '../view_model/auth_events.dart';
import '../widgets/language_toggle_switch.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    Image.asset(AppImages.appLogo),
                    SizedBox(height: 50.h),
                    CustomMainTextFormField(
                      hintText: AppStrings.email.tr(),
                      prefixIcon: AppIcons.emailIcon,
                      controller: emailController,
                      validator: (value) => AppValidations.validateEmail(value),
                    ),
                    SizedBox(height: 20.h),
                    CustomMainTextFormField(
                      hintText: AppStrings.password.tr(),
                      prefixIcon: AppIcons.passwordIcon,
                      controller: passwordController,
                      isSecure: true,
                      validator: (value) =>
                          AppValidations.validatePassword(value),
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.resetPasswordScreen);
                        },
                        child: Text(
                          AppStrings.forgetPassword.tr(),
                          style: AppStyles.primary14400,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    BlocConsumer<AuthBloc, AuthState>(
                      listenWhen: (previous, current) =>
                          previous.loginState != current.loginState,
                      listener: (context, state) {
                        if (state.loginState.errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(state.loginState.errorMessage!)),
                          );
                        }
                        if (state.loginState.data != null) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRoutes.homeScreen, (route) => false);
                        }
                      },
                      builder: (context, state) {
                        return CustomMainButton(
                            text: state.loginState.isLoading
                                ? "..."
                                : AppStrings.login.tr(),
                            onPressed: state.loginState.isLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(
                                            LoginEvent(
                                              AppUser(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                              ),
                                            ),
                                          );
                                    }
                                  });
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.donTHaveAccount.tr(),
                          style: AppStyles.white14400,
                        ),
                        SizedBox(width: 5.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.registerScreen);
                          },
                          child: Text(
                            AppStrings.createOne.tr(),
                            style: AppStyles.primary14900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                                color: AppColors.primary, thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(AppStrings.or.tr(),
                              style: AppStyles.primary14400),
                        ),
                        const Expanded(
                            child: Divider(
                                color: AppColors.primary, thickness: 1)),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    CustomMainButton(
                      text: AppStrings.loginWithGoogle.tr(),
                      prefixIcon: AppIcons.googleIcon,
                      onPressed: () {},
                    ),
                    SizedBox(height: 30.h),
                    LanguageToggleSwitch(),
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
