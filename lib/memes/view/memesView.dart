import 'package:flutter/material.dart';
import 'package:myapp/memes/memes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class MemesView extends StatelessWidget {
  const MemesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Memes')),
        body: BlocProvider(
          create: (_) =>
              MemesBloc(httpClient: http.Client())..add(MemesFetched()),
          child: const MemeList(),
        ));
  }
}