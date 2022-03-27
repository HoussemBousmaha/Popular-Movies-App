import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../providers/movies_provider.dart';

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
