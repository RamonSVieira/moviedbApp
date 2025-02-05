import 'package:flutter/material.dart';
import '../models/movie.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
            SizedBox(height: 16),
            Text(movie.overview, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text('Lançamento: ${movie.releaseDate}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text('Gêneros: ${movie.genres.join(', ')}',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
