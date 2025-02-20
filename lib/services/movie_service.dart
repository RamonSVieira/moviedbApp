import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../utils/constants.dart';
import '../database/movie_database.dart';

class MovieService {
  final String _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZmZkYzBlOTEyM2YzOTQzNTczZmRmOTQ4ZGQyMTY4MSIsIm5iZiI6MTcwODQ4MjI0OC44NjksInN1YiI6IjY1ZDU1ZWM4YjA0NjA1MDE0ODA4MWQ1ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Bl-X1-bO_YBaNKwG1Ldqtqo75-WqK-C3C7u7fcaeix8'; // mantenha o token original

  Future<List<Movie>> fetchMovies() async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/discover/movie?language=pt-BR'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List<Movie> movies = [];

        await MovieDatabase.instance.clearMovies();

        for (var movieJson in jsonResponse['results']) {
          final movie = Movie.fromJson(movieJson);
          movies.add(movie);
          await MovieDatabase.instance.insertMovie(movie);
        }
        return movies;
      } else {
        throw Exception('Falha na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar filmes online: $e. Carregando do banco local.');
      return await MovieDatabase.instance.getMovies();
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${Constants.baseUrl}/search/movie?query=$query&api_key=${Constants.apiKey}'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List<Movie> movies = [];

        for (var movieJson in jsonResponse['results']) {
          final movie = Movie.fromJson(movieJson);
          movies.add(movie);
          await MovieDatabase.instance.insertMovie(movie);
        }
        return movies;
      } else {
        throw Exception('Falha na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print(
          'Erro ao buscar filmes online: $e. Carregando resultados do banco local.');
      final allMovies = await MovieDatabase.instance.getMovies();
      return allMovies
          .where((movie) =>
              movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Map<String, String> _getHeaders() {
    return {
      'Authorization': 'Bearer $_token',
      'Accept': 'application/json',
    };
  }
}
