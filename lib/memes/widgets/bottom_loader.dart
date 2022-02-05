import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 34,
        width: 34,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
