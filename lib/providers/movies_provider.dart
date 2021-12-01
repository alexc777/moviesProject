import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_movies/models/models.dart';

class MoviesProvider extends ChangeNotifier {

  String _apiKey = 'dc78a2c62445f9916c561515ba5d8413';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  
  MoviesProvider() {
    print('Provider inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(this._baseUrl, '3/movie/now_playing', {
      'api_key': this._apiKey,
      'language': this._language,
      'page': '1'
    });

    final response = await http.get(url);
    final nowPlatingResponse = NowPlayingResponse.fromJson(response.body);

    this.onDisplayMovies = nowPlatingResponse.results;

    // Se detecta un cambio, se vuelven a crear los widgets
    notifyListeners();
  }
  
  getPopularMovies() async {
    var url = Uri.https(this._baseUrl, '3/movie/popular', {
      'api_key': this._apiKey,
      'language': this._language,
      'page': '1'
    });

    final response = await http.get(url);
    final pupularResponse = PopularResponse.fromJson(response.body);

    this.popularMovies = [...popularMovies,...pupularResponse.results];

    print(popularMovies[0]);

    // Se detecta un cambio, se vuelven a crear los widgets
    notifyListeners();
  }

}