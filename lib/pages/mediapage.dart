import 'package:flutter/material.dart';
import 'package:movie_app/View_Model/providers/media_provider.dart';

import 'package:movie_app/data/api_services.dart';
import 'package:movie_app/model/base/media_item.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/tv_show.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/pages/tv_show_details_page.dart';
import 'package:movie_app/utils/placeholder.dart';
import 'package:movie_app/widgets/custom_text.dart';
import 'package:movie_app/widgets/media_grid.dart';
import 'package:movie_app/widgets/media_carousel.dart';
import 'package:provider/provider.dart';

class AllMediaPage extends StatefulWidget {
  const AllMediaPage({super.key});

  @override
  AllMediaPageState createState() => AllMediaPageState();
}

class AllMediaPageState extends State<AllMediaPage> {
  @override
  void initState() {
    super.initState();

    final mediaProvider = Provider.of<MediaProvider>(context, listen: false);

    if (mediaProvider.trendingMediaList.isEmpty) {
      mediaProvider.fetchTrendingMedia();
    }
    if (mediaProvider.topRatedMediaList.isEmpty) {
      mediaProvider.fetchTopRatedMedia();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child:
            Consumer<MediaProvider>(builder: (context, mediaProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextWidget(
                  text: "Trending Now",
                ),
                const SizedBox(height: 8),
                mediaProvider.errorMessage != null
                    ? Center(
                        child: Text(mediaProvider.errorMessage.toString()),
                      )
                    : mediaProvider.trendingMediaList.isEmpty
                        ? buildShimmerPlaceholder(
                            width: MediaQuery.of(context).size.width,
                            height: 300)
                        : MediaCarousel(
                            mediaItems: mediaProvider.trendingMediaList),
                const SizedBox(height: 20),
                const CustomTextWidget(text: "Top Rated"),
                const SizedBox(height: 16),
                mediaProvider.topRatedMediaList.isEmpty
                    ? buildShimmerPlaceholder(
                        width: MediaQuery.of(context).size.width, height: 200)
                    : Consumer<MediaProvider>(
                        builder: (context, mediaProvider, _) {
                        return MediaGridView<MediaItem>(
                          items: mediaProvider.topRatedMediaList,
                          errorMessage: "No Movies Found",
                          onItemTap: (item) {
                            if (item is Movie) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailsPage(movie: item),
                                ),
                              );
                            } else if (item is TvShow) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TvShowDetailsPage(tvShow: item),
                                ),
                              );
                            }
                          },
                          getTitle: (item) => item.title,
                          getPosterPath: (item) =>
                              "$imagePath${item.posterPath}",
                          getVoteAverage: (item) => item.voteAverage,
                        );
                      }),
              ],
            ),
          );
        }),
      ),
    );
  }
}
