import 'package:dio/dio.dart';
import 'package:movies_app/config/api/end_points.dart';
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
        'with_cast': true, // ضروري جداً لجلب قائمة الممثلين
        'with_images': true, // لضمان جلب الصور الإضافية
      },
    );

    if (response.data['status'] == 'ok') {
      return MovieDetailsModel.fromJson(response.data['data']['movie']);
    } else {
      throw Exception("Movie not found");
    }
  }
}