import 'package:flutter/material.dart';
import 'package:myapp/memes/memes.dart';

class App extends MaterialApp {
  const App({Key? key}) : super(key: key, home: const MemesView());
}