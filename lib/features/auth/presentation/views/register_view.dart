import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_main_button.dart';
import 'package:movies_app/core/widgets/custom_main_text_form_field.dart';
import 'package:movies_app/features/auth/presentation/view_model/auth_events.dart';

import '../../../../config/di/di.dart';
import '../../../../config/validations/app_validations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../domain/models/app_user.dart';
import '../view_model/auth_bloc.dart';
import '../view_model/auth_state.dart';
import '../widgets/avatar_slider.dart';
import '../widgets/language_toggle_switch.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // final nameController = TextEditingController();
  // final confirmPasswordController = TextEditingController();
  // final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> avatars = [
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
    AppImages.avatar4,
    AppImages.avatar5,
    AppImages.avatar6,
    AppImages.avatar7,
    AppImages.avatar8,
    AppImages.avatar9,
  ];

  int selectedAvatarIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.register.tr(), style: AppStyles.primary20600),
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
                  children: [
                    SizedBox(height: 20.h),
                    AvatarSlider(
                      avatars: avatars,
                      selectedAvatarIndex: selectedAvatarIndex,
                      onPageChanged: (index, _) {
                        selectedAvatarIndex = index;
                      },
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      AppStrings.avatar.tr(),
                      style: AppStyles.white16400,
                    ),
                    SizedBox(height: 15.h),
                    CustomMainTextFormField(
                      hintText: AppStrings.email.tr(),
                      prefixIcon: AppIcons.emailIcon,
                      controller: emailController,
                      validator: (value) => AppValidations.validateEmail(value),
                    ),
                    SizedBox(height: 15.h),
                    CustomMainTextFormField(
                      hintText: AppStrings.password.tr(),
                      prefixIcon: AppIcons.passwordIcon,
                      controller: passwordController,
                      isSecure: true,
                      validator: (value) =>
                          AppValidations.validatePassword(value),
                    ),
                    SizedBox(height: 30.h),
                    BlocConsumer<AuthBloc, AuthState>(
                      listenWhen: (previous, current) =>
                          previous.registerState != current.registerState,
                      listener: (context, state) {
                        if (state.registerState.errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.registerState.errorMessage!),
                            ),
                          );
                        }
                        if (state.registerState.data != null) {
                          print("data: ${state.registerState.data?.email}");
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, AppRoutes.homeScreen, (route) => false);
                        }
                      },
                      builder: (context, state) {
                        return CustomMainButton(
                            text: AppStrings.createAccount.tr(),
                            onPressed:
                                // Logic to create account
                                state.registerState.isLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<AuthBloc>().add(
                                                RegisterEvent(
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
                          AppStrings.alreadyHaveAccount.tr(),
                          style: AppStyles.white14400,
                        ),
                        SizedBox(width: 5.w),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            AppStrings.login.tr(),
                            style: AppStyles.primary14900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
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
