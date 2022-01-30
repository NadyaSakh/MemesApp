import 'package:flutter/material.dart';
import 'package:myapp/memes/memes.dart';

class MemeListItem extends StatelessWidget {
  final String thumbnail;
  final String title;
  final int ups;
  final String postLink;

  const MemeListItem({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.ups,
    required this.postLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.network(thumbnail,
                filterQuality: FilterQuality.low,
                scale: 1,
                width: 250,
                height: 250),
          ),
          MemeDescription(
            title: title,
            ups: ups,
            postLink: postLink,
          ),
          //
        ],
      ),
    );
  }
}