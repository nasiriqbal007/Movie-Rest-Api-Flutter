import 'package:movie_app/data/api_services.dart';
import 'package:movie_app/model/cast_model.dart';
import 'package:movie_app/model/tv_show.dart';

class TvShowRepository {
  final ApiServices _apiServices = ApiServices();

  Future<List<TvShow>> getPopularTVShows() =>
      _apiServices.fetchTVShows('/tv/popular');
  Future<List<TvShow>> getAiringTodayTVShows() =>
      _apiServices.fetchTVShows('/tv/airing_today');
  Future<List<TvShow>> getTopRatedTVShows() =>
      _apiServices.fetchTVShows('/tv/top_rated');
  Future<List<TvShow>> getOnTheAirTVShows() =>
      _apiServices.fetchTVShows('/tv/on_the_air');
  Future<List<TvShow>> getTrendingTvShows() =>
      _apiServices.fetchTVShows('/trending/tv/day');
  Future<List<TvShow>> getSearchTvShows(String query) =>
      _apiServices.searchTVShows(query);
  Future<List<String>> getTVShowTrailers(int tvShowId) =>
      _apiServices.fetchTVShowTrailers(tvShowId);
  Future<List<TvShow>> getSimilarTVShows(int tvShowId) async {
    return _apiServices.fetchSimilarTVShows(tvShowId);
  }

  Future<Credits> getTVShowsCast(int tvShowId) =>
      _apiServices.fetchTVShowCast(tvShowId);
}
