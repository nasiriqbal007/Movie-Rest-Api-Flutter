import 'package:flutter/material.dart';
import 'package:movie_app/View_Model/providers/media_provider.dart';
import 'package:movie_app/data/api_services.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/tv_show.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/pages/tv_show_details_page.dart';
import 'package:movie_app/utils/image_error_helper.dart';

class MediaListTile extends StatelessWidget {
  const MediaListTile({
    super.key,
    required this.mediaProvider,
  });

  final MediaProvider mediaProvider;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade900),
        child: mediaProvider.searchMediaList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: mediaProvider.searchMediaList.length,
                itemBuilder: (context, index) {
                  final mediaItem = mediaProvider.searchMediaList[index];
                  return ListTile(
                    onTap: () {
                      if (mediaItem is Movie) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailsPage(movie: mediaItem),
                          ),
                        );
                        mediaProvider.clearSearch();
                      } else if (mediaItem is TvShow) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TvShowDetailsPage(tvShow: mediaItem),
                          ),
                        );
                        mediaProvider.clearSearch();
                      }
                    },
                    contentPadding: const EdgeInsets.all(8),
                    leading: Container(
                      width: 80,
                      height: 80,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      child: Image.network(
                        "$imagePath${mediaItem.posterPath}",
                        loadingBuilder: customImageLoadingBuilder,
                        errorBuilder: customImageErrorBuilder,
                      ),
                    ),
                    title: Text(
                      mediaItem.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
