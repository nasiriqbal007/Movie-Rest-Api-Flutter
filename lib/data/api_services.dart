import 'package:movie_app/data/api_helper.dart';
import 'package:movie_app/data/constants.dart';
import 'package:movie_app/model/cast_model.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/tv_show.dart';

class ApiServices {
  Future<List<Movie>> fetchMovies(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint?api_key=$apiKey');
    final data = await getRequest(url);
    final List<dynamic> results = data['results'];
    return results.map((movie) => Movie.fromJson(movie)).toList();
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query');
    final data = await getRequest(url);
    final List<dynamic> results = data['results'];
    return results.map((movie) => Movie.fromJson(movie)).toList();
  }

  Future<List<TvShow>> searchTVShows(String query) async {
    final url = Uri.parse('$baseUrl/search/tv?api_key=$apiKey&query=$query');
    final data = await getRequest(url);
    final List<dynamic> results = data['results'];
    return results.map((show) => TvShow.fromJson(show)).toList();
  }

  Future<List<Movie>> fetchSimilarMovies(int movieId) async {
    final url = Uri.parse('$baseUrl/movie/$movieId/similar?api_key=$apiKey');
    final data = await getRequest(url);
    final List<dynamic> results = data['results'];
    return results.map((movie) => Movie.fromJson(movie)).toList();
  }

  Future<Credits> fetchMovieCast(int movieId) async {
    final url = Uri.parse('$baseUrl/movie/$movieId/credits?api_key=$apiKey');
    final data = await getRequest(url);
    return Credits.fromJson(data);
  }

  Future<List<TvShow>> fetchTVShows(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint?api_key=$apiKey');
    final data = await getRequest(url);
    final List<dynamic> results = data['results'];
    return results.map((show) => TvShow.fromJson(show)).toList();
  }

  Future<List<String>> fetchMovieTrailers(int movieId) async {
    final url = Uri.parse('$baseUrl/movie/$movieId/videos?api_key=$apiKey');
    final data = await getRequest(url);
    final results = data['results'] as List<dynamic>;
    return results
        .where(
            (video) => video['site'] == 'YouTube' && video['type'] == 'Trailer')
        .map((video) => video['key'] as String)
        .toList();
  }

  Future<List<String>> fetchTVShowTrailers(int tvShowId) async {
    final url = Uri.parse('$baseUrl/tv/$tvShowId/videos?api_key=$apiKey');
    final data = await getRequest(url);
    final results = data['results'] as List<dynamic>;
    return results
        .where(
            (video) => video['site'] == 'YouTube' && video['type'] == 'Trailer')
        .map((video) => video['key'] as String)
        .toList();
  }

  Future<List<TvShow>> fetchSimilarTVShows(int tvShowId) async {
    final url = Uri.parse('$baseUrl/tv/$tvShowId/similar?api_key=$apiKey');
    final data = await getRequest(url);
    final List<dynamic> results = data['results'];
    return results.map((show) => TvShow.fromJson(show)).toList();
  }

  Future<Credits> fetchTVShowCast(int tvShowId) async {
    final url = Uri.parse('$baseUrl/tv/$tvShowId/credits?api_key=$apiKey');
    final data = await getRequest(url);
    return Credits.fromJson(data);
  }
}
