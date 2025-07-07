import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:space_memory_flutter/page/highscore/bloc/highscore_event.dart';
import 'package:space_memory_flutter/page/highscore/bloc/highscore_state.dart';
import 'package:space_memory_flutter/page/highscore/model/highscore_list_data.dart';
import 'package:space_memory_flutter/shared/service/game_session_service/game_session_service.dart';

class HighscoreBloc extends Bloc<HighscoreEvent, HighscoreState> {
  final GameSessionService _gameSessionService;

  HighscoreBloc()
    : _gameSessionService = GetIt.I<GameSessionService>(),
      super(HighscoreState()) {
    on<RefreshHighscore>(_onRefreshHighscore);
  }

  Future<void> _onRefreshHighscore(
    RefreshHighscore event,
    Emitter<HighscoreState> emit,
  ) async {
    emit(state.copyWith(isBusy: true));
    await _gameSessionService.refreshScores();

    final scores = _gameSessionService.highscores.toList();
    scores.sort((a, b) => b.score.compareTo(a.score));
    final listData =
        scores
            .asMap()
            .entries
            .map(
              (entry) => HighscoreListData(
                entry.key + 1,
                entry.value.playerName,
                entry.value.score,
              ),
            )
            .toList();

    emit(state.copyWith(isBusy: false, listData: listData));
  }
}
