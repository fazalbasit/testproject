import 'package:testproject/models/ImagesDataModel.dart';
import 'package:testproject/models/MovieDeatail.dart';

abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetails movieDetails;
  final ImageResponse Images;

  MovieDetailLoaded(this.movieDetails, this.Images);
}

class MovieDetailError extends MovieDetailState {
  final String error;

  MovieDetailError(this.error);
}

// Define events for movie detail
abstract class MovieDetailEvent {}

class FetchMovieDetail extends MovieDetailEvent {
  final String movieId;

  FetchMovieDetail(this.movieId);
}
