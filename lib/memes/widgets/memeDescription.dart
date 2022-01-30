import 'package:flutter/material.dart';

class MemeDescription extends StatelessWidget {
  final String title;
  final int ups;
  final String postLink;

  const MemeDescription({
    Key? key,
    required this.title,
    required this.ups,
    required this.postLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            postLink,
            style: const TextStyle(fontSize: 12.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            '$ups ups',
            style: const TextStyle(fontSize: 12.0),
          )
        ],
      ),
    );
  }
}