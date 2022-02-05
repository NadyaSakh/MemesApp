part of 'memes_bloc.dart';

abstract class MemesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MemesFetched extends MemesEvent {}

class MemesRefreshed extends MemesEvent {}
