import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_icons.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

import '../../data/data_sources/details_remote_data_source.dart';
import '../../data/repo/details_repo_impl.dart';
import '../view_model/details_bloc.dart';
import '../view_model/details_event.dart';
import '../view_model/details_state.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routName = "movie_details";
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsBloc(
        DetailsRepoImpl(DetailsRemoteDataSourceImpl()),
      )..add(GetMovieDetailsEvent(movieId)),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            if (state is DetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.red),
              );
            } else if (state is DetailsSuccess) {
              final movie = state.movie;
              return _buildUI(movie, context);
            } else if (state is DetailsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: AppStyles.white16400,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildUI(movie, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header (Image, Play Button, Back & Bookmark)
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.network(
                movie.backgroundImage,
                height: 550.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(height: 550.h, color: AppColors.gray),
              ),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.black.withOpacity(.8),
                      AppColors.black,
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 40.h,
                left: 20.w,
                right: 20.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Icon(Icons.bookmark, color: AppColors.white, size: 30),
                  ],
                ),
              ),
              Image.asset(IconsAssets.playMovieIcon, width: 80.w), // زر التشغيل

              // Title & Year inside the Stack overlay
              Positioned(
                bottom: 80.h,
                left: 20.w,
                right: 20.w,
                child: Column(
                  children: [
                    Text(movie.title, textAlign: TextAlign.center, style: AppStyles.white24700),
                    SizedBox(height: 8.h),
                    Text(movie.year.toString(), style: AppStyles.white14400.copyWith(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. Watch Button
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                    ),
                    child: Text("Watch", style: AppStyles.white20700),
                  ),
                ),
                SizedBox(height: 15.h),

                // 3. Info Row (Likes, Duration, Rating)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoItem(Icons.favorite, "15"),
                    _buildInfoItem(Icons.access_time_filled, "${movie.runtime} min"),
                    _buildInfoItem(Icons.star, movie.rating.toString()),
                  ],
                ),

                // 4. Screen Shots Section (الديناميكي)
                _buildSectionTitle("Screen Shots"),
                movie.screenshots.isEmpty
                    ? Text("No screen shots available", style: AppStyles.white14400.copyWith(color: Colors.grey))
                    : SizedBox(
                  height: 160.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movie.screenshots.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Image.network(
                          movie.screenshots[index],
                          width: 280.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(width: 280.w, color: AppColors.gray),
                        ),
                      ),
                    ),
                  ),
                ),

                // 5. Similar Movies Section
                _buildSectionTitle("Similar"),
                SizedBox(
                  height: 200.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Image.network(movie.mediumCoverImage, width: 130.w, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),

                // 6. Summary Section
                _buildSectionTitle("Summary"),
                Text(
                  movie.descriptionFull,
                  style: AppStyles.white14400.copyWith(color: Colors.white70, height: 1.4),
                ),

                // 7. Cast Section (الديناميكي)
                _buildSectionTitle("Cast"),
                movie.cast.isEmpty
                    ? const Text("No cast information available", style: TextStyle(color: Colors.grey))
                    : Column(
                  children: movie.cast.map<Widget>((actor) {
                    return _buildCastItem(
                      actor.name,
                      actor.characterName,
                      actor.urlSmallImage,
                    );
                  }).toList(),
                ),

                // 8. Genres Section
                _buildSectionTitle("Genres"),
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: [
                    _buildGenreChip("Action"),
                    _buildGenreChip("Sci-Fi"),
                    _buildGenreChip("Adventure"),
                  ],
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Text(title, style: AppStyles.white20700),
    );
  }

  Widget _buildInfoItem(IconData icon, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20.sp),
          SizedBox(width: 8.w),
          Text(value, style: AppStyles.white16400),
        ],
      ),
    );
  }

  Widget _buildCastItem(String name, String character, String? imageUrl) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: imageUrl != null && imageUrl.isNotEmpty
                ? Image.network(
              imageUrl,
              width: 60.w,
              height: 60.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(width: 60.w, height: 60.h, color: Colors.grey),
            )
                : Container(width: 60.w, height: 60.h, color: Colors.grey),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name : $name", style: AppStyles.white14400),
                Text("Character : $character",
                    style: AppStyles.white14400.copyWith(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(label, style: AppStyles.white14400),
    );
  }
}