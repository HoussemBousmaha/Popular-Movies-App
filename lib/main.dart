import 'package:flutter/material.dart';

import './widgets/movies_list.dart';

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
