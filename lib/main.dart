import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async => runApp(const MoviesApp());

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // remove the debugShowCheckedModeBanner
      debugShowCheckedModeBanner: false,

      // Main App title.
      title: 'Movie App',

      // Main Widget to build movies list interface.
      home: MoviesList(),
    );
  }
}

class MoviesProvider {
  static const String imagePathPrefix = 'https://image.tmdb.org/t/p/w500/';

  static Future<Map> getJson() async {
    //API Key: To be replaced with your key
    const apiKey = '7832b95dc9b342ffe3f9cf9b6d8f091b';

    //URL endpoint to fetch popular movies
    final apiEndPoint = Uri.parse('http://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity.desc');

    //Making Http request
    final apiResponse = await http.get(apiEndPoint);

    //Parsing data using `dart:convert` library
    return json.decode(apiResponse.body);
  }
}

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

class MovieModel {
  // Class fields for mapping to JSON properties
  final int id;
  final num popularity;
  final int voteCount;
  final bool video;
  final String posterPath;
  final String backdropPath;
  final bool adult;
  final String originalLanguage;
  final String originalTitle;
  final List<dynamic> genreIds;
  final String title;
  final num voteAverage;
  final String overview;
  final String releaseDate;

  // Takes JSON formatted map, and returns `MovieModel` object.
  // This is a special type of constructor.
  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        popularity = json['popularity'],
        voteCount = json['vote_count'],
        video = json['video'],
        posterPath = json['poster_path'],
        adult = json['adult'],
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        genreIds = json['genre_ids'],
        title = json['title'],
        voteAverage = json['vote_average'],
        overview = json['overview'],
        releaseDate = json['release_date'],
        backdropPath = json['backdrop_path'];
}

class MovieTile extends StatelessWidget {
  const MovieTile(this.movie, {Key? key}) : super(key: key);

  final MovieModel movie;

  //Building MovieTile to display movie information better.
  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding around the entry
      padding: const EdgeInsets.all(8.0),
      //Since information is displayed vertically, Column widget is used
      child: Column(
        children: [
          // Resizing image poster based on the screen size whenever the image's path is not null.
          Container(
            // Making image's width to half of the given screen size
            width: MediaQuery.of(context).size.width / 2,

            // Making image's height to one fourth of the given screen size
            height: MediaQuery.of(context).size.height / 4,

            // Making image box visually appealing by dropping shadow
            decoration: BoxDecoration(
              // Making image box slightly curved
              borderRadius: BorderRadius.circular(10.0),

              // Setting box's color to grey
              color: Colors.grey,

              // Decorating image
              image: DecorationImage(
                image: NetworkImage(MoviesProvider.imagePathPrefix + movie.posterPath),
                // Image getting all the available space
                fit: BoxFit.cover,
              ),

              // Dropping shadow
              boxShadow: const [
                BoxShadow(
                  // grey colored shadow
                  color: Colors.grey,
                  // Applying softening effect
                  blurRadius: 3.0,
                  // move 1.0 to right (horizontal), and 3.0 to down (vertical)
                  offset: Offset(1.0, 3.0),
                ),
              ],
            ),
          ),
          // Title widget
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ),
          // Description widget
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.overview,
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
          ),
          // Divider widget
          Divider(color: Colors.grey.shade500),
        ],
      ),
    );
  }
}
