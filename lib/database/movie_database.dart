import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/movie.dart';

class MovieDatabase {
  static final MovieDatabase instance = MovieDatabase._init();
  static Database? _database;

  MovieDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies(
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        releaseDate TEXT,
        genres TEXT
      )
    ''');
  }

  Future<void> insertMovie(Movie movie) async {
    final db = await instance.database;
    await db.insert(
      'movies',
      {
        'id': movie.id,
        'title': movie.title,
        'overview': movie.overview,
        'posterPath': movie.posterPath,
        'releaseDate': movie.releaseDate,
        'genres': movie.genres.join(','), // armazenando como String
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Movie>> getMovies() async {
    final db = await instance.database;
    final maps = await db.query('movies');

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return Movie(
          id: maps[i]['id'] as int,
          title: maps[i]['title'] as String,
          overview: maps[i]['overview'] as String,
          posterPath: maps[i]['posterPath'] as String,
          releaseDate: maps[i]['releaseDate'] as String,
          genres: (maps[i]['genres'] as String)
              .split(','), // convertendo para List<String>
        );
      });
    } else {
      return [];
    }
  }

  Future<void> clearMovies() async {
    final db = await instance.database;
    await db.delete('movies');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
