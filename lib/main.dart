import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app.dart';
import 'package:myapp/appBlocObserver.dart';

void main() {
  BlocOverrides.runZoned(
        () => runApp(const App()),
    blocObserver: AppBlocObserver(),
  );
}


