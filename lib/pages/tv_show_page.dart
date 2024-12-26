import 'package:flutter/material.dart';
import 'package:movie_app/View_Model/providers/tv_show_provider.dart';
import 'package:movie_app/utils/placeholder.dart';
import 'package:movie_app/widgets/custom_text.dart';
import 'package:movie_app/widgets/media_slider.dart';
import 'package:movie_app/widgets/media_carousel.dart';
import 'package:provider/provider.dart';

class TvShowPage extends StatefulWidget {
  const TvShowPage({super.key});

  @override
  TvShowPageState createState() => TvShowPageState();
}

class TvShowPageState extends State<TvShowPage> {
  @override
  void initState() {
    super.initState();

    final tvShowProvider = Provider.of<TvShowProvider>(context, listen: false);

    // Fetch data only if the lists are empty
    if (tvShowProvider.popularTVShows.isEmpty) {
      tvShowProvider.fetchPopularTVShows();
    }
    if (tvShowProvider.airingTodayTVShows.isEmpty) {
      tvShowProvider.fetchAiringTodayTVShows();
    }
    if (tvShowProvider.trendingTVShows.isEmpty) {
      tvShowProvider.fetchTrendingTVShows();
    }
    if (tvShowProvider.topRatedTVShows.isEmpty) {
      tvShowProvider.fetchTopRatedTVShows();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Popular Shows Section
              const CustomTextWidget(text: "Popular Shows"),
              const SizedBox(height: 8),
              Consumer<TvShowProvider>(
                builder: (context, tvShowProvider, child) {
                  return tvShowProvider.errorMessage != null
                      ? Center(
                          child: Text(
                            tvShowProvider.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : tvShowProvider.popularTVShows.isEmpty
                          ? buildShimmerPlaceholder(
                              height: 300,
                              width: MediaQuery.of(context).size.width)
                          : MediaCarousel(
                              mediaItems: tvShowProvider.popularTVShows);
                },
              ),
              const SizedBox(height: 16),

              // Airing Today Section
              const CustomTextWidget(text: "Airing On Today"),
              const SizedBox(height: 8),
              Consumer<TvShowProvider>(
                builder: (context, tvShowProvider, child) {
                  return tvShowProvider.errorMessage != null
                      ? Center(
                          child: Text(
                            tvShowProvider.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : tvShowProvider.airingTodayTVShows.isEmpty
                          ? buildShimmerPlaceholder(
                              height: 200,
                              width: MediaQuery.of(context).size.width)
                          : MediaSlider(
                              mediaItems: tvShowProvider.airingTodayTVShows);
                },
              ),
              const SizedBox(height: 16),

              // Trending TV Shows Section
              const CustomTextWidget(text: "Trending TV Shows"),
              const SizedBox(height: 8),
              Consumer<TvShowProvider>(
                builder: (context, tvShowProvider, child) {
                  return tvShowProvider.errorMessage != null
                      ? Center(
                          child: Text(
                            tvShowProvider.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : tvShowProvider.trendingTVShows.isEmpty
                          ? buildShimmerPlaceholder(
                              height: 200,
                              width: MediaQuery.of(context).size.width)
                          : MediaSlider(
                              mediaItems: tvShowProvider.trendingTVShows);
                },
              ),
              const SizedBox(height: 16),

              // Top Rated Section
              const CustomTextWidget(text: "Top Rated"),
              const SizedBox(height: 8),
              Consumer<TvShowProvider>(
                builder: (context, tvShowProvider, child) {
                  return tvShowProvider.errorMessage != null
                      ? Center(
                          child: Text(
                            tvShowProvider.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : tvShowProvider.topRatedTVShows.isEmpty
                          ? buildShimmerPlaceholder(
                              height: 200,
                              width: MediaQuery.of(context).size.width)
                          : MediaSlider(
                              mediaItems: tvShowProvider.topRatedTVShows);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
