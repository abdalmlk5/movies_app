import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utils/app_icons.dart';
import 'package:movies_app/features/movie_details/presentation/widgets/build_cast_item.dart';
import 'package:movies_app/features/movie_details/presentation/widgets/build_genre_chip.dart';
import 'package:movies_app/features/movie_details/presentation/widgets/build_info_item.dart';
import 'package:movies_app/features/movie_details/presentation/widgets/build_section_title.dart';


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
              return const Center(child: CircularProgressIndicator(color: AppColors.red));
            } else if (state is DetailsSuccess) {
              return _buildUI(state.movie, context);
            } else if (state is DetailsError) {
              return Center(child: Text(state.message, style: AppStyles.white16400));
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
          // Header Section
          Stack(
            alignment: Alignment.center,
            children: [
              Image.network(movie.backgroundImage, height: 550.h, width: double.infinity, fit: BoxFit.cover),
              Container(
                height: 550.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, AppColors.black.withOpacity(.8), AppColors.black],
                  ),
                ),
              ),
              Positioned(
                top: 40.h,
                left: 20.w,
                right: 20.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
                        onPressed: () => Navigator.pop(context)),

                    Image.asset(IconsAssets.saveIcon, width: 30.w, color: AppColors.white),
                  ],
                ),
              ),
              Image.asset(IconsAssets.playMovieIcon, width: 80.w),
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

                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r))),
                    child: Text("Watch", style: AppStyles.white20700),
                  ),
                ),
                SizedBox(height: 20.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const MovieInfoItem(iconPath: IconsAssets.likeIcon, value: "15"),
                    MovieInfoItem(iconPath: IconsAssets.timeIcon, value: "${movie.runtime} min"),
                    MovieInfoItem(iconPath: IconsAssets.rateIcon, value: movie.rating.toString()),
                  ],
                ),
                const SectionTitle(title: "Screen Shots"),
                movie.screenshots.isEmpty
                    ? Text("No screenshots available", style: AppStyles.white14400.copyWith(color: Colors.grey))
                    : SizedBox(
                  height: 160.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movie.screenshots.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Image.network(movie.screenshots[index], width: 280.w, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),


                const SectionTitle(title: "Similar"),
                movie.similarMovies.isEmpty
                    ? Text("No similar movies", style: AppStyles.white14400.copyWith(color: Colors.grey))
                    : SizedBox(
                  height: 200.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movie.similarMovies.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(movieId: movie.similarMovies[index].id))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Image.network(movie.similarMovies[index].mediumCoverImage, width: 130.w, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),

                const SectionTitle(title: "Summary"),
                Text(movie.descriptionFull, style: AppStyles.white14400.copyWith(color: Colors.white70, height: 1.4)),


                const SectionTitle(title: "Cast"),
                movie.cast.isEmpty
                    ? const Text("No cast available", style: TextStyle(color: Colors.grey))
                    : Column(
                    children: movie.cast
                        .map<Widget>((actor) => CastItem(name: actor.name, character: actor.characterName, imageUrl: actor.urlSmallImage))
                        .toList()),


                const SectionTitle(title: "Genres"),
                Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: [for (var g in movie.genres) GenreChip(label: g)]),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}