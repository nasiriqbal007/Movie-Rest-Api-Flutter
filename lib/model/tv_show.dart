import 'package:movie_app/model/base/media_item.dart';

class TvShow implements MediaItem {
  @override
  final int id;
  @override
  final String title;
  final String backDropPath;
  final String originalName;
  final String overview;
  @override
  final String posterPath;
  final String firstAirDate;
  @override
  final double voteAverage;

  TvShow({
    required this.id,
    required this.title,
    required this.backDropPath,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.voteAverage,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      title: json['name'] ?? '',
      backDropPath: json['backdrop_path'] ?? '',
      originalName: json['original_name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      firstAirDate: json['first_air_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      id: json["id"] != null ? json["id"] as int : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': title,
      'backdrop_path': backDropPath,
      'original_name': originalName,
      'overview': overview,
      'poster_path': posterPath,
      'first_air_date': firstAirDate,
      'vote_average': voteAverage,
      'id': id
    };
  }
}
