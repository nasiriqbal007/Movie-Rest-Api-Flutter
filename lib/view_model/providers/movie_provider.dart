import 'package:flutter/material.dart';
import 'package:movie_app/data/movie_repository.dart';
import 'package:movie_app/model/cast_model.dart';
import 'package:movie_app/model/movie.dart';

class MovieProvider extends ChangeNotifier {
  final MovieRepository _movieRepository = MovieRepository();
  List<Movie> _popularMovies = [];
  List<Movie> _nowPlayingMovies = [];
  List<Movie> _upcomingMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _trendingMovies = [];
  List<String> _movieTrailers = [];
  List<Movie> _similarMovies = [];
  List<Movie> _searchMovies = [];

  Credits? _movieCredits; // Store the cast and crew data

  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  List<Movie> get upcomingMovies => _upcomingMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get trendingMovies => _trendingMovies;
  List<String> get movieTrailers => _movieTrailers;
  List<Movie> get similarMovies => _similarMovies;
  Credits? get movieCredits =>
      _movieCredits; // Getter for the cast and crew data
  List<Movie> get searchMovies => _searchMovies;
  String? errorMessage;
  Future<void> searchMovie(String query) async {
    try {
      _searchMovies = await _movieRepository.getSearchMovies(query);

      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> fetchSimilarMovies(int movieId) async {
    try {
      final movies = await _movieRepository.getSimilarMovies(movieId);
      _similarMovies = movies;
      notifyListeners();
    } catch (error) {
      errorMessage = error.toString();
    }
  }

  Future<void> fetchPopularMovies() async {
    try {
      _popularMovies = await _movieRepository.getPopularMovies();
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to load popular movies';
      notifyListeners();
    }
  }

  Future<void> fetchNowPlayingMovies() async {
    try {
      _nowPlayingMovies = await _movieRepository.getNowPlayingMovies();
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to load now playing movies';
      notifyListeners();
    }
  }

  Future<void> fetchUpcomingMovies() async {
    try {
      _upcomingMovies = await _movieRepository.getUpcomingMovies();
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to load upcoming movies';
      notifyListeners();
    }
  }

  Future<void> fetchTopRatedMovies() async {
    try {
      _topRatedMovies = await _movieRepository.getTopRatedMovies();
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to load top-rated movies';
      notifyListeners();
    }
  }

  Future<void> fetchTrendingMovies() async {
    try {
      _trendingMovies = await _movieRepository.getTrendingMovies();
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to load trending movies';
      notifyListeners();
    }
  }

  Future<void> fetchMovieTrailers(int movieId) async {
    try {
      _movieTrailers.clear();
      _movieTrailers = await _movieRepository.getMovieTrailers(movieId);
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to load trailers';
      notifyListeners();
    }
    notifyListeners();
  }

  // Fetch movie cast and crew
  Future<Credits?> fetchMovieCast(int movieId) async {
    try {
      _movieCredits = await _movieRepository.getMovieCast(movieId);
      notifyListeners();
      return _movieCredits;
    } catch (e) {
      errorMessage = 'Failed to load movie credits (cast and crew)';
      notifyListeners();
    }
    return null;
  }
}
