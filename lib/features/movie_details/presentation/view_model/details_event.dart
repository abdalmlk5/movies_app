abstract class DetailsEvent {}
class GetMovieDetailsEvent extends DetailsEvent {
  final int movieId;
  GetMovieDetailsEvent(this.movieId);
}