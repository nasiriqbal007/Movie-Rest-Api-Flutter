import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/model/movie.dart';

const apiKey = 'add your api key here';
const imagePath = "https://image.tmdb.org/t/p/w500";

class ApiServices {
  final popularMoviesApi =
      'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';
  final nowPlayingMoviesApi =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey";
  final upComingMoviesApi =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey';

  Future<List<Movie>> getPopularMovies() async {
    Uri url = Uri.parse(popularMoviesApi);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<Movie> movie = data.map((movie) => Movie.fromJson(movie)).toList();
      return movie;
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    Uri url = Uri.parse(nowPlayingMoviesApi);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<Movie> movie = data.map((movie) => Movie.fromJson(movie)).toList();
      return movie;
    } else {
      throw Exception("FAiled to load Data");
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    Uri url = Uri.parse(upComingMoviesApi);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<Movie> movie = data.map((movie) => Movie.fromJson(movie)).toList();
      return movie;
    } else {
      throw Exception("Failed to load Data");
    }
  }
}
