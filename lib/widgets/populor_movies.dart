import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/details_page.dart';
import 'package:movie_app/services/api_services.dart';

class PopulorMovies extends StatelessWidget {
  const PopulorMovies({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index, realIndex) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailsPage(movie: snapshot.data[index])));
          },
          child: SizedBox(
            height: 300,
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                '$imagePath${snapshot.data[index].posterPath}', // Replace with your image URL or dynamic path
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 300,
        viewportFraction: 0.60,
        enlargeCenterPage: true,
        pageSnapping: true,
        autoPlay: true,
      ),
    );
  }
}
