import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:testproject/controller/dio/DioClient.dart';
import 'package:testproject/controller/bloc_cubits/ApiCubits/GetMoviesCubitStates.dart';
import 'package:testproject/models/MovieResponse.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final DioClient dioClient;

  MovieBloc(this.dioClient) : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await dioClient.get('movie/upcoming');
        Map<String, dynamic> jsonMap = json.decode(movies.data);
        MovieResponse movieslist = MovieResponse.fromJson(jsonMap);
        emit(MovieLoaded(movieslist.results));
      } catch (error) {
        emit(MovieError(error.toString()));
      }
    });
  }
}
