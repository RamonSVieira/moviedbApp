import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          Image.network('https://image.tmdb.org/t/p/w92${movie.posterPath}'),
      title: Text(movie.title),
      subtitle: Text(movie.overview),
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: movie);
      },
    );
  }
}
