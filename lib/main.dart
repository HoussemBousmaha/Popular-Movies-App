import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String apiKey = '7832b95dc9b342ffe3f9cf9b6d8f091b';
final apiEndPoint = Uri.parse('http://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity.desc');

void main() async {
  final apiResponse = await http.get(apiEndPoint);
  // print(apiResponse.body);
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

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
