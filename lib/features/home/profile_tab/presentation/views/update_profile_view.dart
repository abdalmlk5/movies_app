import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/config/api/firebase/firebase_functions.dart';
import 'package:movies_app/config/di/di.dart';
import 'package:movies_app/core/models/app_user.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_main_button.dart';
import 'package:movies_app/core/widgets/custom_main_text_form_field.dart';
import 'package:movies_app/features/home/profile_tab/presentation/view_model/profile_bloc.dart';
import 'package:movies_app/features/home/profile_tab/presentation/view_model/profile_event.dart';
import 'package:movies_app/features/home/profile_tab/presentation/view_model/profile_state.dart';
import 'package:movies_app/features/home/profile_tab/presentation/widgets/profile_avatar_selector.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late int selectedAvatarIndex;
  late AppUser user;
  bool _isInitialized = false;

  final List<String> avatars = AppImages.avatars;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      user = ModalRoute.of(context)!.settings.arguments as AppUser;
      nameController = TextEditingController(text: user.name);
      phoneController = TextEditingController(text: user.phone);
      selectedAvatarIndex = user.avatarID;
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _showAvatarPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AvatarPickerBottomSheet(
        avatars: avatars,
        selectedAvatarIndex: selectedAvatarIndex,
        onAvatarSelected: (index) {
          setState(() => selectedAvatarIndex = index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>(),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
          if (state.updateSuccess) {
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.black,
            appBar: AppBar(
              backgroundColor: AppColors.black,
              elevation: 0,
              centerTitle: true,
              title: Text(AppStrings.pickAvatar.tr(),
                  style: AppStyles.primary20600),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Center(
                      child: ProfileAvatarSelector(
                        selectedAvatarIndex: selectedAvatarIndex,
                        onTap: () => _showAvatarPicker(context),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomMainTextFormField(
                      controller: nameController,
                      hintText: AppStrings.name.tr(),
                      prefixIcon: AppIcons.profileIcon,
                    ),
                    SizedBox(height: 20.h),
                    CustomMainTextFormField(
                      controller: phoneController,
                      hintText: AppStrings.phoneNumber.tr(),
                      prefixIcon: AppIcons.phoneIcon,
                    ),
                    SizedBox(height: 20.h),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                          context, AppRoutes.resetPasswordScreen),
                      child: Text(
                        AppStrings.resetPassword.tr(),
                        style: AppStyles.white20400,
                      ),
                    ),
                    SizedBox(height: 100.h),
                    CustomMainButton(
                      text: AppStrings.deleteAccount.tr(),
                      onPressed: () {
                        FirebaseFunctions.deleteUser(user.userID);
                        context
                            .read<ProfileBloc>()
                            .add(DeleteProfileEvent(user.userID));
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.loginScreen,
                          (route) => false,
                        );
                      },
                      backgroundColor: AppColors.red,
                      textStyle: AppStyles.white20400,
                    ),
                    SizedBox(height: 16.h),
                    CustomMainButton(
                      text: AppStrings.updateData.tr(),
                      textStyle: AppStyles.black20400,
                      onPressed: () {
                        final updatedUser = AppUser(
                          userID: user.userID,
                          name: nameController.text,
                          email: user.email,
                          password: user.password,
                          phone: phoneController.text,
                          avatarID: selectedAvatarIndex,
                          watchList: user.watchList,
                          history: user.history,
                        );
                        context
                            .read<ProfileBloc>()
                            .add(UpdateProfileEvent(updatedUser));
                      },
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.black,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
