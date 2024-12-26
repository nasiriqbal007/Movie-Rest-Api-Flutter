import 'package:flutter/material.dart';
import 'package:movie_app/View_Model/providers/movie_provider.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/widgets/actor_cast_list.dart';
import 'package:movie_app/widgets/custom_text.dart';
import 'package:movie_app/widgets/media_grid.dart';
import 'package:movie_app/widgets/my_sliver_app_bar.dart';

import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<MovieProvider>(context, listen: false);
    provider.fetchMovieCast(widget.movie.id);
    provider.fetchSimilarMovies(widget.movie.id);
    provider.fetchMovieTrailers(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: CustomScrollView(
          slivers: [
            Consumer<MovieProvider>(
              builder: (context, provider, child) {
                return MySliverAppBar(
                  data: provider.movieTrailers,
                  errorMessage: provider.errorMessage,
                );
              },
            ),

            // Main Content (Movie Details)
            SliverList(
              delegate: SliverChildListDelegate([
                // Poster and Details Section
                movieDetails(),
                const SizedBox(height: 16),

                // Cast Section
                const CustomTextWidget(text: "Cast"),
                const SizedBox(height: 16),
                Consumer<MovieProvider>(
                  builder: (context, provider, child) {
                    final credits = provider.movieCredits;

                    if (credits == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ActorCastList(castList: credits.cast);
                  },
                ),

                const SizedBox(
                  height: 16,
                ),

                const CustomTextWidget(text: "Similar Movies"),
                const SizedBox(
                  height: 16,
                ),
                Consumer<MovieProvider>(
                  builder: (context, provider, child) {
                    return provider.similarMovies.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : MediaGridView<Movie>(
                            getPosterPath: (movie) => movie.posterPath,
                            items: provider.similarMovies,
                            errorMessage: provider.errorMessage.toString(),
                            onItemTap: (movie) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetailsPage(movie: movie),
                                ),
                              );
                            },
                            getTitle: (movie) => movie.title,
                            getVoteAverage: (movie) => movie.voteAverage,
                          );
                  },
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget movieDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left - Poster
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              '$imagePath${widget.movie.posterPath}',
              width: 150,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),

          // Right - Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Title
                Text(
                  widget.movie.title,
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
                      size: 16,
                      Icons.star,
                      color: Colors.amber.shade500,
                    ),
                    Text(widget.movie.voteAverage.toStringAsFixed(1)),
                  ],
                ),
                // Release Date
                Row(
                  children: [
                    const Text(
                      "Release Date: ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      widget.movie.releaseDate,
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
                  widget.movie.overview,
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
