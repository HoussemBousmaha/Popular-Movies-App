import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../providers/movies_provider.dart';
import './movie_tile.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  // List of movies to hold data parsed from api response
  List<MovieModel> movies = <MovieModel>[];

  void fetchMovies() async {
    // Fetching data from server
    var data = await MoviesProvider.getJson();

    // Holding data from server in generic list results
    List<dynamic> results = data['results'];

    setState(() {
      // Iterating over results list and converting to MovieModel
      for (var element in results) {
        // adding MovieModel object to movies list
        movies.add(MovieModel.fromJson(element));
      }
    });
  }

  @override
  void initState() {
    //This method is called once when the widet starts first time
    fetchMovies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SingleChildScollView to accommodate dynamically sized data
      body: ListView.builder(
        // Calculating number of items using `movies` variable
        itemCount: movies.length,

        //Passing widget handle as `context`, and `index` to process one item at a time
        itemBuilder: (context, index) {
          return Padding(
            // Adding padding around the list row
            padding: const EdgeInsets.all(8.0),

            // Using MovieTile object to render movie's title, description and image
            child: MovieTile(movies[index]),
          );
        },
      ),
    );
  }
}
