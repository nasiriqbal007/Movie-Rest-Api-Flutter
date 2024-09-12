import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/widgets/movie_slider.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/widgets/custom_text.dart';
import 'package:movie_app/widgets/populor_movies.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> nowPlayingMovies;
  late Future<List<Movie>> upComingMovies;

  @override
  void initState() {
    popularMovies = ApiServices().getPopularMovies();
    nowPlayingMovies = ApiServices().getNowPlayingMovies();
    upComingMovies = ApiServices().getUpcomingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie App"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextWidget(text: "Populor Movies"),
            const SizedBox(
              height: 08,
            ),
            FutureBuilder<List<Movie>>(
              future: popularMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Failed to load movies'),
                  );
                }

                if (snapshot.hasData) {
                  final movies = snapshot.data!;

                  if (movies.isEmpty) {
                    return const Center(
                      child: Text('No movies available'),
                    );
                  }

                  return PopulorMovies(snapshot: snapshot);
                } else {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
              },
            ),
            const CustomTextWidget(text: "Now Playing"),
            FutureBuilder<List<Movie>>(
              future: nowPlayingMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Failed to load movies'),
                  );
                }

                if (snapshot.hasData) {
                  final movies = snapshot.data!;

                  if (movies.isEmpty) {
                    return const Center(
                      child: Text('No movies available'),
                    );
                  }

                  return MovieSlider(snapshot: snapshot);
                } else {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
              },
            ),
            const CustomTextWidget(text: "Upcoming Movies"),
            FutureBuilder<List<Movie>>(
              future: upComingMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Failed to load movies'),
                  );
                }

                if (snapshot.hasData) {
                  final movies = snapshot.data!;

                  if (movies.isEmpty) {
                    return const Center(
                      child: Text('No movies available'),
                    );
                  }

                  return MovieSlider(snapshot: snapshot);
                } else {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
