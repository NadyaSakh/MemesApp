part of 'memes_bloc.dart';

enum MemesStatus { initial, success, failure, refreshing }

class MemesState extends Equatable {
  const MemesState({
    this.status = MemesStatus.initial,
    this.memes = const <Meme>[],
    this.hasReachedMax = false,
  });

  final MemesStatus status;
  final List<Meme> memes;
  final bool hasReachedMax;

  MemesState copyWith({
    MemesStatus? status,
    List<Meme>? memes,
    bool? hasReachedMax,
  }) {
    return MemesState(
      status: status ?? this.status,
      memes: memes ?? this.memes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''MemesState { status: $status, hasReachedMax: $hasReachedMax, memes: ${memes.length} }''';
  }

  @override
  List<Object?> get props => [status, memes, hasReachedMax];
}
