import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/components/CustomBlueButton.dart';
import 'package:testproject/components/CustomOutlineButton.dart';
import 'package:testproject/controller/dio/DioClient.dart';
import 'package:testproject/controller/bloc_cubits/MovieDetailCubit/MovieDetailScreenCubit.dart';
import 'package:testproject/controller/bloc_cubits/MovieDetailCubit/MovieDetailScreenStates.dart';
import 'package:testproject/models/ImagesDataModel.dart';
import 'package:testproject/models/MovieDeatail.dart';
import 'package:testproject/screens/TheaterScreen.dart';
import 'package:testproject/screens/VideoPlayerScreen.dart';
import 'package:testproject/utils/globals.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);
  final String movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieDetailCubit(DioClient('https://api.themoviedb.org/3/'))
            ..fetchMovieDetail(movieId),
      child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(state, context),
          );
        },
      ),
    );
  }

  Widget _buildBody(MovieDetailState state, BuildContext context) {
    if (state is MovieDetailLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is MovieDetailLoaded) {
      return _buildContent(state.movieDetails, state.Images, context);
    } else if (state is MovieDetailError) {
      return Center(child: Text('Error: ${state.error}'));
    } else {
      return const Center(child: Text('No data'));
    }
  }

  Widget _buildContent(MovieDetails movieDetails, ImageResponse movieImages,
      BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                children: [
                  Image.network(
                    "https://image.tmdb.org/t/p/w500/${movieDetails.posterPath}",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    colorBlendMode: BlendMode.darken,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.1),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 15,
                              )),
                          const Text(
                            "Watch",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ]),
              Positioned(
                  bottom: 60,
                  left: 60,
                  right: 60,
                  child: Column(
                    children: [
                      const Text(
                        "In theaters december 22, 2021",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomBlueButton(() async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TheaterScreen(movieId: movieId),
                              ),
                            );
                          }, "Get Tickets"))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(child: CustomBorderedButton(() async {
                            DioClient dioClient = DioClient('');
                            var reponse =
                                await dioClient.get("movie/${movieId}/videos");
                            print(reponse.data);
                            var data = json.decode(reponse.data);
                            var firstItem = data['results'][0];
                            var videoId = firstItem['key'];
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FullScreenVideoPlayer(videoId: videoId),
                              ),
                            );
                          })),
                        ],
                      )
                    ],
                  ))
            ],
          ),
          Container(
            margin: const EdgeInsets.all(25),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      "Genres",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movieDetails.genres.length,
                    itemBuilder: (context, index) {
                      final colorIndex = index % colors.length;

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5),
                        decoration: BoxDecoration(
                          color: colors[colorIndex],
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Center(
                          child: Text(
                            movieDetails.genres[index].name,
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "Overview",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(movieDetails.overview)
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Adjust as needed
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: movieImages.images.length,
            itemBuilder: (context, index) {
              return InstaImageViewer(
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/${movieImages.images[index].filePath}',
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
