import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async => runApp(const MovieApp());

class MovieApp extends StatefulWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  // Variable to store movie data
  var movies;

  // Method to fetch movies
  void fetchMovies() async {
    //Store JSON response in `data` variable
    var data = await MoviesProvider.getJson();

    //The `setState` method triggers to rebuild intereface
    setState(() => movies = data['results']);
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // remove the debugShowCheckedModeBanner
      debugShowCheckedModeBanner: false,

      // Main App title.
      title: 'Movie App',

      // Main Home Page.
      home: Scaffold(),
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
