import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repo/details_repo.dart';
import 'details_event.dart';
import 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final DetailsRepo detailsRepo;

  DetailsBloc(this.detailsRepo) : super(DetailsInitial()) {
    on<GetMovieDetailsEvent>((event, emit) async {
      emit(DetailsLoading());
      try {
        final movie = await detailsRepo.fetchMovieDetails(event.movieId);
        emit(DetailsSuccess(movie));
      } catch (e) {
        emit(DetailsError(e.toString()));
      }
    });
  }
}