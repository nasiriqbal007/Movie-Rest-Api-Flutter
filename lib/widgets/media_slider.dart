import 'package:flutter/material.dart';
import 'package:movie_app/data/api_services.dart';
import 'package:movie_app/model/base/media_item.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/tv_show.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/pages/tv_show_details_page.dart';
import 'package:movie_app/utils/image_error_helper.dart';

class MediaSlider extends StatelessWidget {
  final List<MediaItem> mediaItems;

  const MediaSlider({
    super.key,
    required this.mediaItems,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mediaItems.length,
        itemBuilder: (context, index) {
          final item = mediaItems[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                if (item is Movie) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsPage(movie: item),
                    ),
                  );
                } else if (item is TvShow) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TvShowDetailsPage(tvShow: item)),
                  );
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 200,
                  child: Image.network(
                    '$imagePath${item.posterPath}',
                    fit: BoxFit.cover,
                    errorBuilder: customImageErrorBuilder,
                    loadingBuilder: customImageLoadingBuilder,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
