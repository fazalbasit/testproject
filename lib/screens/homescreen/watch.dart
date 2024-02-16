import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/components/MovieItem.dart';
import 'package:testproject/controller/dio/DioClient.dart';
import 'package:testproject/controller/bloc_cubits/ApiCubits/GetMoviesCubit.dart';
import 'package:testproject/controller/bloc_cubits/ApiCubits/GetMoviesCubitStates.dart';
import 'package:testproject/controller/bloc_cubits/SearchQueryCubit/SearchCubit.dart';
import 'package:testproject/controller/bloc_cubits/SearchQueryCubit/SearchCubitStates.dart';

class Watch extends StatelessWidget {
  const Watch({Key? key});

  @override
  Widget build(BuildContext context) {
    DioClient dioClient = DioClient('https://api.themoviedb.org/3/');
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc(dioClient)..add(FetchMovies()),
        ),
        BlocProvider<SearchQueryCubit>(
          create: (_) => SearchQueryCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<SearchQueryCubit, SearchQueryState>(
            builder: (context, state) {
              return !state.isSearching
                  ? const Text("Watch")
                  : TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Type in your text',
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            BlocProvider.of<SearchQueryCubit>(context)
                                .setQuery('', false);
                          },
                        ),
                      ),
                      onChanged: (value) {
                        BlocProvider.of<SearchQueryCubit>(context)
                            .setQuery(value, true);
                      },
                    );
            },
          ),
          actions: [
            BlocBuilder<SearchQueryCubit, SearchQueryState>(
              builder: (context, state) {
                return state.isSearching
                    ? Container()
                    : IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          BlocProvider.of<SearchQueryCubit>(context)
                              .toggleSearch();
                          BlocProvider.of<SearchQueryCubit>(context)
                              .setQuery(' ', true);
                        },
                      );
              },
            ),
          ],
        ),
        body: BlocBuilder<SearchQueryCubit, SearchQueryState>(
          builder: (context, searchState) {
            return Column(
              children: [
                Expanded(
                  child: BlocBuilder<MovieBloc, MovieState>(
                    builder: (context, state) {
                      if (state is MovieLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is MovieError) {
                        return Center(child: Text('Error: ${state.error}'));
                      } else if (state is MovieLoaded) {
                        final movies = searchState.query.isEmpty
                            ? state.movies
                            : state.movies
                                .where((movie) => movie.title
                                    .toLowerCase()
                                    .contains(searchState.query.toLowerCase()))
                                .toList();

                        if (searchState.isSearching) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              return MovieItem(filteredMovies: movies[index]);
                            },
                          );
                        }
                        return ListView.builder(
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            return MovieItem(filteredMovies: movies[index]);
                          },
                        );
                      } else {
                        return const Center(child: Text('No data'));
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
