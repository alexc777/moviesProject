import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_movies/models/models.dart';

class MoviesProvider extends ChangeNotifier {

  String _apiKey = 'dc78a2c62445f9916c561515ba5d8413';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Cast> castMovies = [];
  List<Cast> teamMovies = [];
  List<SimilarMovie> similarsMovies = [];
  List<TopRatedMovie> topRatedMovies = [];
  List<ReviewsMovie> listReviewsMovies = [];
  
  MoviesProvider() {
    print('Provider inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
    this.getTopRatedMovies();
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

    // Se detecta un cambio, se vuelven a crear los widgets
    notifyListeners();
  }
  
  Future<List> getPepolMovie(int idMovie) async {
    var url = Uri.https(this._baseUrl, '3/movie/${idMovie}/credits', {
      'api_key': this._apiKey,
      'language': this._language,
      'page': '1'
    });

    final response = await http.get(url);
    final pepolResponse = PepolResponse.fromJson(response.body);

    this.castMovies = pepolResponse.cast;
    this.teamMovies = pepolResponse.crew;

    return [castMovies, teamMovies];
  }

  Future<List<SimilarMovie>> getsimilarMovies(int idMovie) async {
    var url = Uri.https(this._baseUrl, '3/movie/${idMovie}/similar', {
      'api_key': this._apiKey,
      'language': this._language,
      'page': '1'
    });

    final response = await http.get(url);
    final similarResponse = SimilarResponse.fromJson(response.body);

    this.similarsMovies = similarResponse.results;

    return similarsMovies;
  }

  Future<List<ReviewsMovie>> getReviewsMovies(int idMovie) async {
    var url = Uri.https(this._baseUrl, '3/movie/${idMovie}/reviews', {'api_key': this._apiKey});

    final response = await http.get(url);
    final reviewsResponse = ReviewsResponse.fromJson(response.body);

    this.listReviewsMovies = reviewsResponse.results;

    return listReviewsMovies;
  }

  getTopRatedMovies() async {
    var url = Uri.https(this._baseUrl, '3/movie/top_rated', {
      'api_key': this._apiKey,
      'language': this._language,
      'page': '1'
    });

    final response = await http.get(url);
    final topRatedResponse = TopratedResponse.fromJson(response.body);

    this.topRatedMovies = topRatedResponse.results;

    // Se detecta un cambio, se vuelven a crear los widgets
    notifyListeners();
  }

  // sendRated(int idMovie, double valueRated) async {
  //   var url = Uri.https(this._baseUrl, '3/movie/${idMovie}/rating', {'api_key': this._apiKey,});

  //   Map<String, String> headersPost = {
  //     'Content-Type': 'application/json;charset=utf-8'
  //   };



  //   final response = await http.post(url, headers:headersPost, body: { 'value': valueRated });

  //   print('POST: ${response.body}');
  // }

}