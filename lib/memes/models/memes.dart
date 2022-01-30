import 'package:myapp/memes/models/meme.dart';

class Memes {
  final int count;
  final List<Meme> memes;

  Memes({required this.count, required this.memes});

  factory Memes.fromJson(Map<String, dynamic> json) {
    return Memes(
        count: json['count'],
        memes: json['memes'].map<Meme>((json) => Meme.fromJson(json)).toList());
  }
}