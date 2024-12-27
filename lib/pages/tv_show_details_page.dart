import 'package:flutter/material.dart';
import 'package:movie_app/View_Model/providers/tv_show_provider.dart';
import 'package:movie_app/model/tv_show.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/utils/image_error_helper.dart';
import 'package:movie_app/widgets/actor_cast_list.dart';
import 'package:movie_app/widgets/custom_text.dart';
import 'package:movie_app/widgets/media_grid.dart';
import 'package:movie_app/widgets/my_sliver_app_bar.dart';
import 'package:provider/provider.dart';

class TvShowDetailsPage extends StatefulWidget {
  final TvShow tvShow;

  const TvShowDetailsPage({super.key, required this.tvShow});

  @override
  State<TvShowDetailsPage> createState() => _TvShowDetailsPageState();
}

class _TvShowDetailsPageState extends State<TvShowDetailsPage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<TvShowProvider>(context, listen: false);
    provider.fetchTvShowCast(widget.tvShow.id);
    provider.fetchSimilarTvShow(widget.tvShow.id);
    provider.fetchTvShowTrailers(widget.tvShow.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: CustomScrollView(
          slivers: [
            // SliverAppBar
            Consumer<TvShowProvider>(
              builder: (context, provider, child) {
                return MySliverAppBar(
                  data: provider.tvShowTrailer,
                  errorMessage: provider.errorMessage,
                );
              },
            ),

            // Main Content (TV Show Details)
            SliverList(
              delegate: SliverChildListDelegate([
                // Poster and Details Section
                tvShowDetails(),
                const SizedBox(height: 20),

                // Cast Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Cast",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Consumer<TvShowProvider>(
                  builder: (context, provider, child) {
                    final credits = provider.tvShowCredits;

                    if (credits == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ActorCastList(castList: credits.cast),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const CustomTextWidget(text: "Similar Shows"),

                // Similar6TV Shows
                Consumer<TvShowProvider>(
                  builder: (context, provider, child) {
                    return provider.similarTVShows.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: MediaGridView<TvShow>(
                              getPosterPath: (tvShow) => tvShow.posterPath,
                              items: provider.similarTVShows,
                              errorMessage: provider.errorMessage.toString(),
                              onItemTap: (tvShow) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TvShowDetailsPage(tvShow: tvShow),
                                  ),
                                );
                              },
                              getTitle: (tvShow) => tvShow.title,
                              getVoteAverage: (tvShow) => tvShow.voteAverage,
                            ),
                          );
                  },
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  // TV Show Details Section
  Widget tvShowDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left - Poster (TV show)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              '$imagePath${widget.tvShow.posterPath}',
              width: 150,
              height: 220,
              fit: BoxFit.cover,
              loadingBuilder: customImageLoadingBuilder,
              errorBuilder: customImageErrorBuilder,
            ),
          ),
          const SizedBox(width: 16),

          // Right - TV Show Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.tvShow.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text("Ratings:"),
                    Icon(
                      Icons.star,
                      color: Colors.amber.shade500,
                    ),
                    Text(widget.tvShow.voteAverage.toStringAsFixed(1)),
                  ],
                ),

                Row(
                  children: [
                    const Text(
                      "First Air Date: ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      widget.tvShow.firstAirDate,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Overview
                const Text(
                  "Overview",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.tvShow.overview,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
