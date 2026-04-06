import 'package:dio/dio.dart';
import 'package:movies_app/config/api/end_points.dart';

import '../../../../core/models/movie_model.dart';
import '../models/movie_details_model.dart';

abstract class DetailsRemoteDataSource {
  Future<MovieDetailsModel> getMovieDetails(int movieId);
}

class DetailsRemoteDataSourceImpl implements DetailsRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await dio.get(
      EndPoints.movieDetails,
      queryParameters: {
        'movie_id': movieId,
        'with_cast': true,
        'with_images': true,
      },
    );

    final suggestionsResponse = await dio.get(
      EndPoints.movieSuggestions,
      queryParameters: {'movie_id': movieId},
    );

    if (response.data['status'] == 'ok') {
      List<MovieModel> similar = [];
      if (suggestionsResponse.data['data']['movies'] != null) {
        similar = (suggestionsResponse.data['data']['movies'] as List)
            .map((m) => MovieModel.fromJson(m))
            .toList();
      }
      return MovieDetailsModel.fromJson(
          response.data['data']['movie'], similar);
    } else {
      throw Exception("Movie not found");
    }
  }
}
