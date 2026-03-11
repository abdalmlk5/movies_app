import 'package:dio/dio.dart';
import 'package:movies_app/config/api/end_points.dart';
import 'package:movies_app/features/home/home_tab/data/models/movie_model.dart';
import 'package:movies_app/features/home/home_tab/domain/repo/home_repo.dart';


class HomeRepoImpl implements HomeRepo {
  final Dio dio = Dio();

  @override
  Future<List<MovieModel>> fetchMovies() async {
    var response = await dio.get(EndPoints.listMovies);
    List<MovieModel> movies = [];
    if (response.data['data']['movies'] != null) {
      for (var movie in response.data['data']['movies']) {
        movies.add(MovieModel.fromJson(movie));
      }
    }
    return movies;
  }
}