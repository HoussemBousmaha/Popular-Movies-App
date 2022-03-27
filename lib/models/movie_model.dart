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
