import 'package:flutter/material.dart';
import 'package:myapp/memes/bloc/memesBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _refreshData() {
      context.read<MemesBloc>().add(MemesRefreshed());
    }

    return Positioned(
        right: 20,
        bottom: 20,
        child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              child: Icon(Icons.refresh),
              onPressed: _refreshData,
            )));
  }
}
