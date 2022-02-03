import 'package:myapp/memes/models/meme.dart';
import 'package:equatable/equatable.dart';

class Memes extends Equatable {
  final int count;
  final List<Meme> memes;

  const Memes({required this.count, required this.memes});

  factory Memes.fromJson(Map<String, dynamic> json) {
    return Memes(
        count: json['count'],
        memes: json['memes'].map<Meme>((json) => Meme.fromJson(json)).toList());
  }

  @override
  List<Object> get props => [count, memes];
}
