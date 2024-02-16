import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testproject/controller/dio/DioClient.dart';
import 'package:testproject/models/MovieImages.dart';

class MovieImageScreen extends StatefulWidget {
  @override
  _MovieImageScreenState createState() => _MovieImageScreenState();
}

// c0f26acc8c09faccf7550112896ecfeb

// eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMGYyNmFjYzhjMDlmYWNjZjc1NTAxMTI4OTZlY2ZlYiIsInN1YiI6IjY1YzhlOWFkMjY2Nzc4MDE3YzU5M2NlYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KaZF5P8GNjXJYoCAFIOqXu8ZVhix9PpYDxVSYW0ph3U

class _MovieImageScreenState extends State<MovieImageScreen> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Your API key
    DioClient dioClient = DioClient('https://api.themoviedb.org/3/');

    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : const Text('Watch'),
        actions: _buildAppBarActions(),
      ),
      body: Container(
        child: FutureBuilder(
          future: dioClient.get('movie/866398/images'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              Map<String, dynamic> jsonMap = json.decode(snapshot.data!.data);

              // Create a MovieResponse object using the fromJson factory method
              MovieImages movies = MovieImages.fromJson(jsonMap);

              // List<dynamic> movies = snapshot.data as List<dynamic>;
              return ListView.builder(
                itemCount: movies.posters.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(movies.posters[index].filePath),
                    subtitle: Text(""),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(80.0),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[200]),
        hintText: "Type in your text",
        fillColor: Colors.grey[200],
        prefix: const Icon(
          Icons.search,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _searchController.clear();
              _isSearching = false;
            });
          },
        ),
      ),
      onChanged: (value) {
        // Handle search query
      },
    );
  }

  List<Widget> _buildAppBarActions() {
    return _isSearching
        ? []
        : [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
            ),
          ];
  }
}
