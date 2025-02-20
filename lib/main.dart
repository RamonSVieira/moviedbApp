import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/login_screen.dart';
import 'services/movie_service.dart';
import 'providers/user_provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => MovieService()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Movie Series App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/detail': (context) => DetailScreen(),
        },
      ),
    );
  }
}
