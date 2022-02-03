import 'package:equatable/equatable.dart';

class Meme extends Equatable {
  final String postLink;
  final String subreddit;
  final String title;
  final String url;
  final bool nsfw;
  final bool spoiler;
  final String author;
  final int ups;
  final List<dynamic> preview;

  const Meme(
      {required this.postLink,
      required this.subreddit,
      required this.title,
      required this.url,
      required this.nsfw,
      required this.spoiler,
      required this.author,
      required this.ups,
      required this.preview});

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
        postLink: json['postLink'],
        subreddit: json['subreddit'],
        title: json['title'],
        url: json['url'],
        nsfw: json['nsfw'],
        spoiler: json['spoiler'],
        author: json['author'],
        ups: json['ups'],
        preview: json['preview']);
  }

  @override
  List<Object> get props =>
      [postLink, subreddit, title, url, nsfw, spoiler, author, ups, preview];
}
