import 'package:flutter/material.dart';
import 'homepage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Possible Band Names',
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      home: BandNames(title: 'Possible Band Names'),
    );
  }
}
