import 'package:testproject/models/MovieResponse.dart';

abstract class MovieEvent {}

class FetchMovies extends MovieEvent {}

// Define states
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  MovieLoaded(this.movies);
}

class MovieError extends MovieState {
  final String error;

  MovieError(this.error);
}
