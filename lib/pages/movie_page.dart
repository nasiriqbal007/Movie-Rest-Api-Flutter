import 'package:flutter/material.dart';
import 'package:movie_app/View_Model/providers/movie_provider.dart';
import 'package:movie_app/utils/placeholder.dart';
import 'package:movie_app/widgets/custom_text.dart';
import 'package:movie_app/widgets/media_slider.dart';
import 'package:movie_app/widgets/media_carousel.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  MoviePageState createState() => MoviePageState();
}

class MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    // Fetch data only once when the page loads
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    if (movieProvider.popularMovies.isEmpty) {
      movieProvider.fetchPopularMovies();
    }
    if (movieProvider.nowPlayingMovies.isEmpty) {
      movieProvider.fetchNowPlayingMovies();
    }
    if (movieProvider.upcomingMovies.isEmpty) {
      movieProvider.fetchUpcomingMovies();
    }
    if (movieProvider.topRatedMovies.isEmpty) {
      movieProvider.fetchTopRatedMovies();
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
              // Popular Movies Section
              const CustomTextWidget(text: "Popular Movies"),
              const SizedBox(height: 8),
              Consumer<MovieProvider>(builder: (context, movieProvider, child) {
                return movieProvider.errorMessage != null
                    ? Center(
                        child: Text(
                          movieProvider.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : movieProvider.popularMovies.isEmpty
                        ? buildShimmerPlaceholder(
                            height: 300,
                            width: MediaQuery.of(context).size.width)
                        : MediaCarousel(
                            mediaItems: movieProvider.popularMovies);
              }),
              const SizedBox(height: 16),

              // Now Playing Section
              const CustomTextWidget(text: "Now Playing"),
              const SizedBox(height: 8),
              Consumer<MovieProvider>(builder: (context, movieProvider, child) {
                return movieProvider.errorMessage != null
                    ? Center(
                        child: Text(
                          movieProvider.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : movieProvider.nowPlayingMovies.isEmpty
                        ? buildShimmerPlaceholder(
                            height: 200,
                            width: MediaQuery.of(context).size.width)
                        : MediaSlider(
                            mediaItems: movieProvider.nowPlayingMovies);
              }),
              const SizedBox(height: 16),

              // Upcoming Movies Section
              const CustomTextWidget(text: "Upcoming Movies"),
              const SizedBox(height: 8),
              Consumer<MovieProvider>(builder: (context, movieProvider, child) {
                return movieProvider.errorMessage != null
                    ? Center(
                        child: Text(
                          movieProvider.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : movieProvider.upcomingMovies.isEmpty
                        ? buildShimmerPlaceholder(
                            height: 200,
                            width: MediaQuery.of(context).size.width)
                        : MediaSlider(mediaItems: movieProvider.upcomingMovies);
              }),
              const SizedBox(height: 16),

              // Top Rated Movies Section
              const CustomTextWidget(text: "Top Rated"),
              const SizedBox(height: 8),
              Consumer<MovieProvider>(builder: (context, movieProvider, child) {
                return movieProvider.errorMessage != null
                    ? Center(
                        child: Text(
                          movieProvider.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : movieProvider.topRatedMovies.isEmpty
                        ? buildShimmerPlaceholder(
                            height: 200,
                            width: MediaQuery.of(context).size.width)
                        : MediaSlider(mediaItems: movieProvider.topRatedMovies);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
