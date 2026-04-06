import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';

class ProfileAvatarSelector extends StatelessWidget {
  final int selectedAvatarIndex;
  final VoidCallback onTap;

  const ProfileAvatarSelector({
    super.key,
    required this.selectedAvatarIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 140.r,
            height: 140.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withAlpha(25),
            ),
          ),
          CircleAvatar(
            radius: 60.r,
            backgroundColor: Colors.transparent,
            backgroundImage:
                AssetImage(AppImages.getAvatar(selectedAvatarIndex)),
          ),
        ],
      ),
    );
  }
}

class AvatarPickerBottomSheet extends StatelessWidget {
  final List<String> avatars;
  final int selectedAvatarIndex;
  final Function(int) onAvatarSelected;

  const AvatarPickerBottomSheet({
    super.key,
    required this.avatars,
    required this.selectedAvatarIndex,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
            ),
            itemCount: avatars.length,
            itemBuilder: (context, index) {
              final int avatarId = index + 1;
              final bool isSelected = selectedAvatarIndex == avatarId;
              return GestureDetector(
                onTap: () {
                  onAvatarSelected(avatarId);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withAlpha(76)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                    border: isSelected
                        ? Border.all(color: AppColors.primary, width: 2)
                        : null,
                  ),
                  child: Image.asset(avatars[index]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
