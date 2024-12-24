import 'package:movie_app/data/api_services.dart';
import 'package:movie_app/model/cast_model.dart';
import 'package:movie_app/model/movie.dart';

class MovieRepository {
  final ApiServices _apiServices = ApiServices();

  Future<List<Movie>> getPopularMovies() =>
      _apiServices.fetchMovies('/movie/popular');
  Future<List<Movie>> getNowPlayingMovies() =>
      _apiServices.fetchMovies('/movie/now_playing');
  Future<List<Movie>> getUpcomingMovies() =>
      _apiServices.fetchMovies('/movie/upcoming');
  Future<List<Movie>> getTopRatedMovies() =>
      _apiServices.fetchMovies('/movie/top_rated');
  Future<List<Movie>> getTrendingMovies() =>
      _apiServices.fetchMovies('/trending/movie/day');
  Future<List<Movie>> getSearchMovies(String query) =>
      _apiServices.searchMovies(query);

  Future<List<String>> getMovieTrailers(int movieId) =>
      _apiServices.fetchMovieTrailers(movieId);
  Future<List<Movie>> getSimilarMovies(int movieId) async {
    return _apiServices.fetchSimilarMovies(movieId);
  }

  Future<Credits> getMovieCast(int movieId) =>
      _apiServices.fetchMovieCast(movieId);
}
