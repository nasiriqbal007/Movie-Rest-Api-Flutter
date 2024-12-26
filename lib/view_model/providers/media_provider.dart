import 'package:flutter/material.dart';
import 'package:movie_app/View_Model/providers/movie_provider.dart';
import 'package:movie_app/View_Model/providers/tv_show_provider.dart';
import 'package:movie_app/model/base/media_item.dart';

class MediaProvider extends ChangeNotifier {
  final MovieProvider _movieProvider;
  final TvShowProvider _tvShowProvider;

  MediaProvider({
    required MovieProvider movieProvider,
    required TvShowProvider tvShowProvider,
  })  : _movieProvider = movieProvider,
        _tvShowProvider = tvShowProvider;

  bool _isSearchActive = false;
  bool get isSearchActive => _isSearchActive;
  TextEditingController controller = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<MediaItem> get trendingMediaList {
    return [
      ..._movieProvider.trendingMovies,
      ..._tvShowProvider.trendingTVShows,
    ];
  }

  List<MediaItem> get searchMediaList {
    return [
      ..._movieProvider.searchMovies,
      ..._tvShowProvider.searchTVShows,
    ];
  }

  List<MediaItem> get topRatedMediaList {
    return [
      ..._movieProvider.topRatedMovies,
      ..._tvShowProvider.topRatedTVShows,
    ];
  }

  Future<void> fetchTrendingMedia() async {
    try {
      await _movieProvider.fetchTrendingMovies();
      await _tvShowProvider.fetchTrendingTVShows();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load trending media';
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchTopRatedMedia() async {
    try {
      await _movieProvider.fetchTopRatedMovies();
      await _tvShowProvider.fetchTopRatedTVShows();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load top-rated media';
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchSearchMedia(String query) async {
    if (query.isEmpty) {
      clearSearch();
      return;
    }

    _isSearchActive = true;
    try {
      await _movieProvider.searchMovie(query);
      await _tvShowProvider.searchTvShows(query);
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Error fetching search media';
    } finally {
      notifyListeners();
    }
  }

  void clearSearch() {
    _isSearchActive = false;
    _errorMessage = null;
    controller.clear();

    notifyListeners();
  }
}
