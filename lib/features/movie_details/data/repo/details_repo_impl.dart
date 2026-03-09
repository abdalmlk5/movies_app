import '../../domain/repo/details_repo.dart';
import '../data_sources/details_remote_data_source.dart';
import '../models/movie_details_model.dart';class DetailsRepoImpl implements DetailsRepo {
  final DetailsRemoteDataSource remoteDataSource;
  DetailsRepoImpl(this.remoteDataSource);

  @override
  Future<MovieDetailsModel> fetchMovieDetails(int movieId) async {
    return await remoteDataSource.getMovieDetails(movieId);
  }
}
