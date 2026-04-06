import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/config/di/di.dart';
import 'package:movies_app/core/models/movie_model.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_main_button.dart';
import 'package:movies_app/core/widgets/movie_poster_card.dart';
import 'package:movies_app/features/home/profile_tab/presentation/view_model/profile_bloc.dart';
import 'package:movies_app/features/home/profile_tab/presentation/view_model/profile_event.dart';
import 'package:movies_app/features/home/profile_tab/presentation/view_model/profile_state.dart';
import 'package:movies_app/features/home/profile_tab/presentation/widgets/profile_section_button.dart';
import 'package:movies_app/features/home/profile_tab/presentation/widgets/profile_stat_widget.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  // Dummy data for Watch List
  final List<MovieModel> dummyWatchList = [
    MovieModel(
      id: 53353,
      title: "Deadpool & Wolverine",
      mediumCoverImage:
          "https://yts.mx/assets/images/movies/deadpool_wolverine_2024/medium-cover.jpg",
      rating: 7.9,
    ),
    MovieModel(
      id: 54631,
      title: "Inside Out 2",
      mediumCoverImage:
          "https://yts.mx/assets/images/movies/inside_out_2_2024/medium-cover.jpg",
      rating: 7.7,
    ),
    MovieModel(
      id: 55225,
      title: "Twisters",
      mediumCoverImage:
          "https://yts.mx/assets/images/movies/twisters_2024/medium-cover.jpg",
      rating: 7.1,
    ),
  ];

  // Dummy data for History
  final List<MovieModel> dummyHistory = [
    MovieModel(
      id: 55431,
      title: "Despicable Me 4",
      mediumCoverImage:
          "https://yts.mx/assets/images/movies/despicable_me_4_2024/medium-cover.jpg",
      rating: 6.3,
    ),
    MovieModel(
      id: 53123,
      title: "Furiosa",
      mediumCoverImage:
          "https://yts.mx/assets/images/movies/furiosa_a_mad_max_saga_2024/medium-cover.jpg",
      rating: 7.6,
    ),
    MovieModel(
      id: 53124,
      title: "The Fall Guy",
      mediumCoverImage:
          "https://yts.mx/assets/images/movies/the_fall_guy_2024/medium-cover.jpg",
      rating: 6.9,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(LoadProfileEvent()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
          if (state.logoutSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.loginScreen,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          }

          if (state.user == null) {
            return const SizedBox();
          }

          final user = state.user!;

          // Separate logic to show different dummy lists based on selected index
          final bool isWatchListTab = state.selectedSectionIndex == 0;
          final List<MovieModel> actualList =
              isWatchListTab ? user.watchList : user.history;

          final List<MovieModel> currentList = actualList.isEmpty
              ? (isWatchListTab ? dummyWatchList : dummyHistory)
              : actualList;

          return Scaffold(
            backgroundColor: AppColors.black,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 50.r,
                                  backgroundImage: AssetImage(
                                      AppImages.getAvatar(user.avatarID)),
                                ),
                                SizedBox(height: 8.h),
                                Text(user.name, style: AppStyles.white20700),
                              ],
                            ),
                            const Spacer(),
                            ProfileStatWidget(
                                label: AppStrings.watchList.tr(),
                                count: user.watchList.length.toString()),
                            const Spacer(),
                            ProfileStatWidget(
                                label: AppStrings.history.tr(),
                                count: user.history.length.toString()),
                            const Spacer(),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomMainButton(
                                text: AppStrings.editProfile.tr(),
                                onPressed: () async {
                                  final profileBloc =
                                      context.read<ProfileBloc>();
                                  final result = await Navigator.pushNamed(
                                    context,
                                    AppRoutes.updateProfileScreen,
                                    arguments: user,
                                  );
                                  if (result == true) {
                                    profileBloc.add(LoadProfileEvent());
                                  }
                                },
                                backgroundColor: AppColors.primary,
                                borderRadius: 15.r,
                                height: 50,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: CustomMainButton(
                                text: AppStrings.exit.tr(),
                                onPressed: () => context
                                    .read<ProfileBloc>()
                                    .add(LogoutProfileEvent()),
                                isLoading: state.isLoggingOut,
                                backgroundColor: AppColors.red,
                                prefixIcon: AppIcons.exitIcon,
                                borderRadius: 15.r,
                                height: 50,
                                textColor: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      ProfileSectionButton(
                        title: AppStrings.watchList.tr(),
                        index: 0,
                        selectedIndex: state.selectedSectionIndex,
                        iconPath: AppIcons.menuIcon,
                        onTap: () => context
                            .read<ProfileBloc>()
                            .add(ChangeProfileSectionEvent(0)),
                      ),
                      ProfileSectionButton(
                        title: AppStrings.history.tr(),
                        index: 1,
                        selectedIndex: state.selectedSectionIndex,
                        iconPath: AppIcons.folderIcon,
                        onTap: () => context
                            .read<ProfileBloc>()
                            .add(ChangeProfileSectionEvent(1)),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.all(20.r),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16.h,
                        crossAxisSpacing: 16.w,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: currentList.length,
                      itemBuilder: (context, index) {
                        final item = currentList[index];
                        return MoviePosterCard(
                          rating: item.rating.toString(),
                          imageUrl: item.mediumCoverImage,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
