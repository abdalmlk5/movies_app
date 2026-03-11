import '../../data/models/movie_details_model.dart';

abstract class DetailsState {}
class DetailsInitial extends DetailsState {}
class DetailsLoading extends DetailsState {}
class DetailsSuccess extends DetailsState {
  final MovieDetailsModel movie;
  DetailsSuccess(this.movie);
}
class DetailsError extends DetailsState {
  final String message;
  DetailsError(this.message);
}