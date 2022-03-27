import 'dart:convert';

import 'package:http/http.dart' as http;

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
