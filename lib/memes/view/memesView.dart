import 'package:flutter/material.dart';
import 'package:myapp/memes/memes.dart';

class MemesView extends StatelessWidget {
  const MemesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memes',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const MemeList(),
    );
  }
}