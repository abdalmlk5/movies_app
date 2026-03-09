import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:movies_app/features/home/home_tab/data/models/movie_model.dart';
import 'package:movies_app/features/home/widget/movie_poster_card.dart';
import 'package:movies_app/features/movie_details/presentation/views/MovieDetailsScreen.dart';

class MovieCarousel extends StatefulWidget {
  final List<MovieModel> movies;
  const MovieCarousel({super.key, required this.movies});

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  late PageController _pageController;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.6, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) => setState(() => _currentPage = value),
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          double scale = _currentPage == index ? 1.0 : 0.8;
          return TweenAnimationBuilder(
            duration: const Duration(milliseconds: 350),
            tween: Tween(begin: scale, end: scale),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: GestureDetector(
// في ملف movie_carousel.dart
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(movieId: widget.movies[index].id),
                        ),
                      );
                    },



                  child: MoviePosterCard(
                    imageUrl: widget.movies[index].mediumCoverImage,
                    rating: widget.movies[index].rating.toString(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}