import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/memes/models/meme.dart';
import 'package:myapp/memes/utils/dio_client.dart';
import 'package:stream_transform/stream_transform.dart';

part 'memes_event.dart';

part 'memes_state.dart';

const _memesPortionCount = 10;
const _maxFetchCount = 100;

const throttleDuration = Duration(microseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MemesBloc extends Bloc<MemesEvent, MemesState> {
  MemesBloc({required this.client}) : super(const MemesState()) {
    on<MemesFetched>(
      _onMemesFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<MemesRefreshed>(
      _onMemesRefreshed,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  DioClient client = DioClient();

  Future<void> _onMemesFetched(
    MemesFetched event,
    Emitter<MemesState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == MemesStatus.initial) {
        final memes = await client.fetchMemes(_memesPortionCount);
        return emit(state.copyWith(
          status: MemesStatus.success,
          memes: memes,
          hasReachedMax: false,
        ));
      }

      final isMaxFetched = state.memes.length >= _maxFetchCount;

      if (isMaxFetched) {
        emit(state.copyWith(hasReachedMax: true));
      } else {
        final memes = await client.fetchMemes(_memesPortionCount);
        emit(
          state.copyWith(
            status: MemesStatus.success,
            memes: List.of(state.memes)..addAll(memes),
            hasReachedMax: false,
          ),
        );
      }
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

      final memes = await client.fetchMemes(_memesPortionCount);
      return emit(state.copyWith(
        status: MemesStatus.success,
        memes: memes,
        hasReachedMax: false,
      ));
    } catch (_) {
      emit(state.copyWith(status: MemesStatus.failure));
    }
  }
}
