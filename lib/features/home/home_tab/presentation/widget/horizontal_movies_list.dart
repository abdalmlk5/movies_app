import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:movies_app/features/home/home_tab/data/models/movie_model.dart';
import 'package:movies_app/features/movie_details/presentation/views/MovieDetailsScreen.dart';

import 'movie_poster_card.dart';

class HorizontalMoviesList extends StatelessWidget {
  final List<MovieModel> movies;

  const HorizontalMoviesList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 16.w),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 12.w),

              child:  GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsScreen(movieId: movies[index].id),
                    ),
                  );
                },
                child: MoviePosterCard(
                  imageUrl: movies[index].mediumCoverImage,
                  rating: movies[index].rating.toString(),
                  width: 140.w,
                ),
              ),

          );
        },
      ),
    );
  }
}