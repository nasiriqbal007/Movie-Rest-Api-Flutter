import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/api_services.dart';
import 'package:movie_app/model/base/media_item.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/tv_show.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/pages/tv_show_details_page.dart';
import 'package:movie_app/utils/image_error_helper.dart';

class MediaCarousel extends StatelessWidget {
  final List<MediaItem> mediaItems;

  const MediaCarousel({
    super.key,
    required this.mediaItems,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: mediaItems.length,
      itemBuilder: (context, index, realIndex) {
        final item = mediaItems[index];
        return GestureDetector(
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
                  builder: (context) => TvShowDetailsPage(tvShow: item),
                ),
              );
            }
          },
          child: SizedBox(
            height: 300,
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                '$imagePath${item.posterPath}', // Ensure imagePath is defined globally or in the widget
                fit: BoxFit.cover,
                errorBuilder: customImageErrorBuilder,
                loadingBuilder: customImageLoadingBuilder,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 300,
        viewportFraction: 0.56,
        enlargeCenterPage: true,
        pageSnapping: true,
        autoPlay: true,
      ),
    );
  }
}
