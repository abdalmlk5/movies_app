
import 'package:movies_app/features/home/home_tab/data/models/movie_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<MovieModel> movies; // القائمة القادمة من الـ API
  HomeSuccess(this.movies);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}