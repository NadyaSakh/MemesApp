import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/memes/models/meme.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/memes/models/memes.dart';
import 'package:stream_transform/stream_transform.dart';

part 'memesEvent.dart';

part 'memesState.dart';

const _memesPortionCount = 10;
const _maxFetchCount = 200;

const throttleDuration = Duration(microseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MemesBloc extends Bloc<MemesEvent, MemesState> {
  MemesBloc({required this.httpClient}) : super(const MemesState()) {
    on<MemesFetched>(
      _onMemesFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<MemesRefreshed>(
      _onMemesRefreshed,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onMemesFetched(
    MemesFetched event,
    Emitter<MemesState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == MemesStatus.initial) {
        final memes = await _fetchMemes();
        return emit(state.copyWith(
          status: MemesStatus.success,
          memes: memes,
          hasReachedMax: false,
        ));
      }
      final memes = await _fetchMemes();
      final isMaxFetched =
          state.memes.length + _memesPortionCount > _maxFetchCount;
      isMaxFetched
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: MemesStatus.success,
                memes: List.of(state.memes)..addAll(memes),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: MemesStatus.failure));
    }
  }

  Future<void> _onMemesRefreshed(
    MemesRefreshed event,
    Emitter<MemesState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: MemesStatus.refreshing,
        memes: [],
        hasReachedMax: false,
      ));

      final memes = await _fetchMemes();
      return emit(state.copyWith(
        status: MemesStatus.success,
        memes: memes,
        hasReachedMax: false,
      ));
    } catch (_) {
      emit(state.copyWith(status: MemesStatus.failure));
    }
  }

  Future<List<Meme>> _fetchMemes() async {
    final response = await httpClient.get(
      Uri.https('meme-api.herokuapp.com', '/gimme/$_memesPortionCount'),
    );
    if (response.statusCode == 200) {
      final body = Memes.fromJson(jsonDecode(response.body));
      return body.memes;
    }

    throw Exception('Error fetching memes');
  }
}
