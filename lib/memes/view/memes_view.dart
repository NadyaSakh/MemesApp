import 'package:flutter/material.dart';
import 'package:myapp/memes/memes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/memes/utils/dio_client.dart';

class MemesView extends StatelessWidget {
  const MemesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Memes')),
        body: BlocProvider(
          create: (_) =>
              MemesBloc(client: DioClient())..add(MemesFetched()),
          child: const MemeList(),
        ));
  }
}