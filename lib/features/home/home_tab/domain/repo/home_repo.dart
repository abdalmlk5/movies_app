import '../../data/models/movie_model.dart';

abstract class HomeRepo {
  Future<List<MovieModel>> fetchMovies();
}