import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
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

  Widget _buildImage() {
    return CachedNetworkImage(
      imageUrl: thumbnail,
      imageBuilder: (context, imageProvider) => Center(
        child: Image(
          image: imageProvider,
          width: 250,
          height: 250,
        ),
      ),
      placeholder: (context, url) => const Padding(
          padding: EdgeInsets.fromLTRB(130.0, 130.0, 130.0, 130.0),
          child: Icon(Icons.panorama_sharp)),
      errorWidget: (context, url, error) {
        if (kDebugMode) {
          print(error);
        }
        return Image.asset(
          'assets/memes/sad.png',
          width: 100,
          height: 100,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(child: _buildImage()),
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
