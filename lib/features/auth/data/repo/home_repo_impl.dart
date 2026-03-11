import 'package:dio/dio.dart';
import 'package:movies_app/config/api/end_points.dart';
import 'package:movies_app/features/home/home_tab/data/models/movie_model.dart';
import 'package:movies_app/features/home/home_tab/domain/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final Dio dio = Dio();

  @override
  Future<List<MovieModel>> fetchMovies() async {
    try {
      var response = await dio.get(EndPoints.listMovies);

      if (response.statusCode == 200) {

        List<dynamic> moviesJson = response.data['data']['movies'];

        return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      throw Exception("Error fetching movies: $e");
    }
  }
}