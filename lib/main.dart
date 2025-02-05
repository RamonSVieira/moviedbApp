import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart'; // Import the DetailScreen
import 'services/movie_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) =>
          MovieService(), // Use Provider instead of ChangeNotifierProvider
      child: MaterialApp(
        title: 'Movie Series App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/detail': (context) => DetailScreen(),
        },
      ),
    );
  }
}
