import '../../data/models/movie_details_model.dart';

abstract class DetailsRepo {
  Future<MovieDetailsModel> fetchMovieDetails(int movieId);
}