import 'package:flutter/material.dart';
import 'package:movie_app/data/tv_show_repo.dart';
import 'package:movie_app/model/cast_model.dart';
import 'package:movie_app/model/tv_show.dart';

class TvShowProvider extends ChangeNotifier {
  final TvShowRepository _tvShowRepository = TvShowRepository();

  List<TvShow> _popularTvShows = [];
  List<TvShow> _airingTodayTvShows = [];
  List<TvShow> _topRatedTVShows = [];
  List<TvShow> _onTheAirTVShows = [];
  List<TvShow> _trendingTvShows = [];
  List<TvShow> _similarTvShows = [];
  List<String> _tvShowTrailer = [];
  List<TvShow> _searchTVShows = [];
  Credits? _tvShowCredits;
  String? _errorMessage;

  List<TvShow> get popularTVShows => _popularTvShows;
  List<TvShow> get airingTodayTVShows => _airingTodayTvShows;
  List<TvShow> get topRatedTVShows => _topRatedTVShows;
  List<TvShow> get onTheAirTVShows => _onTheAirTVShows;
  List<TvShow> get trendingTVShows => _trendingTvShows;
  List<TvShow> get similarTVShows => _similarTvShows;
  List<String> get tvShowTrailer => _tvShowTrailer;
  String? get errorMessage => _errorMessage;
  Credits? get tvShowCredits => _tvShowCredits;
  List<TvShow> get searchTVShows => _searchTVShows;

  Future<void> searchTvShows(String query) async {
    try {
      _searchTVShows = await _tvShowRepository.getSearchTvShows(query);
      notifyListeners();
    } catch (e) {
      _errorMessage = "An error occurred while searching TV shows.";
      notifyListeners();
    }
  }

  Future<void> fetchTvShowTrailers(int tvShowid) async {
    try {
      _tvShowTrailer.clear();
      _tvShowTrailer = await _tvShowRepository.getTVShowTrailers(tvShowid);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to load trailers. Please try again.";
      notifyListeners();
    }
  }

  Future<void> fetchPopularTVShows() async {
    try {
      _popularTvShows = await _tvShowRepository.getPopularTVShows();
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to fetch popular TV shows. Please try again.";
      notifyListeners();
    }
  }

  Future<void> fetchAiringTodayTVShows() async {
    try {
      _airingTodayTvShows = await _tvShowRepository.getAiringTodayTVShows();
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to fetch airing today TV shows.";
      notifyListeners();
    }
  }

  Future<void> fetchTopRatedTVShows() async {
    try {
      _topRatedTVShows = await _tvShowRepository.getTopRatedTVShows();
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to fetch top-rated TV shows.";
      notifyListeners();
    }
  }

  Future<void> fetchOnTheAirTVShows() async {
    try {
      _onTheAirTVShows = await _tvShowRepository.getOnTheAirTVShows();
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to fetch TV shows currently on air.";
      notifyListeners();
    }
  }

  Future<void> fetchTrendingTVShows() async {
    try {
      _trendingTvShows = await _tvShowRepository.getTrendingTvShows();
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to fetch trending TV shows.";
      notifyListeners();
    }
  }

  Future<Credits?> fetchTvShowCast(int tvShowId) async {
    try {
      _tvShowCredits = await _tvShowRepository.getTVShowsCast(tvShowId);
      notifyListeners();
      return _tvShowCredits;
    } catch (e) {
      _errorMessage = "Failed to load TV show cast information.";
      notifyListeners();
    }
    return null;
  }

  Future<void> fetchSimilarTvShow(int tvShowId) async {
    try {
      final tvShows = await _tvShowRepository.getSimilarTVShows(tvShowId);
      _similarTvShows = tvShows;
      notifyListeners();
    } catch (error) {
      _errorMessage = "Failed to fetch similar TV shows.";
    }
  }
}
