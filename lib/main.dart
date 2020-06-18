import 'package:flutter/material.dart';

import './screens/dashboard_screen.dart';
import './screens/movie_details_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task - Intellore',
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
      routes: {
        MovieDetailsScreen.routeName: (ctx) => MovieDetailsScreen(),
      },
    );
  }
}
