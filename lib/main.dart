import 'package:flutter/material.dart';
import 'package:movie_app/View_Model/providers/media_provider.dart';
import 'package:movie_app/View_Model/providers/page_provider.dart';
import 'package:movie_app/View_Model/providers/tv_show_provider.dart';
import 'package:movie_app/pages/homepage.dart';
import 'package:movie_app/View_Model/providers/movie_provider.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MovieProvider()),
        ChangeNotifierProvider(create: (context) => TvShowProvider()),
        ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(
            create: (context) => MediaProvider(
                  movieProvider:
                      Provider.of<MovieProvider>(context, listen: false),
                  tvShowProvider:
                      Provider.of<TvShowProvider>(context, listen: false),
                )),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
