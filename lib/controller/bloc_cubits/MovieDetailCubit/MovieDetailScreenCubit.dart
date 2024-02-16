import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/controller/dio/DioClient.dart';
import 'package:testproject/controller/bloc_cubits/MovieDetailCubit/MovieDetailScreenStates.dart';
import 'package:testproject/models/ImagesDataModel.dart';
import 'package:testproject/models/MovieDeatail.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final DioClient dioClient;

  MovieDetailCubit(this.dioClient) : super(MovieDetailInitial());

  Future<void> fetchMovieDetail(String movieId) async {
    emit(MovieDetailLoading());
    try {
      final response = await dioClient.get('movie/$movieId');
      final responseData = response.data;

      final Map<String, dynamic> jsonMap = json.decode(responseData);
      final movieDetails = MovieDetails.fromJson(jsonMap);

      final response2 = await dioClient.get('movie/$movieId/images');
      final responseData2 = response2.data;
      final Map<String, dynamic> jsonMap2 = json.decode(responseData2);
      final movieImages = ImageResponse.fromJson(jsonMap2);

      print("Response Data2  : ${movieImages.images[10].filePath}");

      emit(MovieDetailLoaded(movieDetails, movieImages));
    } catch (error) {
      emit(MovieDetailError(error.toString()));
    }
  }
}
