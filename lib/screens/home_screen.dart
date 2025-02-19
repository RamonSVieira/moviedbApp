import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';
import '../widgets/movie_item.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> futureMovies;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    futureMovies =
        Provider.of<MovieService>(context, listen: false).fetchMovies();
  }

  void _searchMovies(String query) {
    setState(() {
      searchQuery = query;
      futureMovies =
          Provider.of<MovieService>(context, listen: false).searchMovies(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<UserProvider>(context).username),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar filmes',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchMovies(searchController.text);
                  },
                ),
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  _searchMovies('');
                }
              },
              onSubmitted: _searchMovies,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Movie>>(
              future: futureMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar filmes'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum filme encontrado'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return MovieItem(movie: snapshot.data![index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
