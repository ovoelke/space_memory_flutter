import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:space_memory_flutter/page/memory_game/bloc/memory_game_event.dart';
import 'package:space_memory_flutter/page/memory_game/bloc/memory_game_state.dart';
import 'package:space_memory_flutter/page/memory_game/model/memory_card.dart';
import 'package:space_memory_flutter/shared/service/game_session_service/game_session_service.dart';


class MemoryGameBloc extends Bloc<MemoryGameEvent, MemoryGameState> {
  final GameSessionService _gameSessionService;

  MemoryGameBloc()
    : _gameSessionService = GetIt.I<GameSessionService>(),
      super(MemoryGameState(cards: [])) {
    on<InitializeGame>(_onInitializeGame);
    on<FlipCard>(_onFlipCard);
  }

  Future<void> _onInitializeGame(
    InitializeGame event,
    Emitter<MemoryGameState> emit,
  ) async {
    emit(state.copyWith(isBusy: true));
    await _gameSessionService.sessionStart();
    final images = [...event.images, ...event.images]..shuffle();
    final cards =
        images.map((path) => MemoryCard(imageAssetPath: path)).toList();
    emit(state.copyWith(isBusy: false));
    emit(MemoryGameState(cards: cards));
  }

  Future<void> _onFlipCard(
    FlipCard event,
    Emitter<MemoryGameState> emit,
  ) async {
    final index = event.index;
    final cards = List<MemoryCard>.from(state.cards);

    if (cards[index].isFlipped ||
        cards[index].isMatched ||
        state.isBusy ||
        state.hasWon) {
      return;
    }
    // flip selected card
    cards[index] = cards[index].copyWith(isFlipped: true);

    final firstIndex = state.firstFlippedIndex;

    // first card
    if (firstIndex == null || firstIndex == -1) {
      emit(state.copyWith(cards: cards, firstFlippedIndex: index));
      return;
    }
    // seconds card
    emit(state.copyWith(cards: cards, isBusy: true));

    final match =
        cards[firstIndex].imageAssetPath == cards[index].imageAssetPath;

    if (match) {
      _gameSessionService.increaseSessionPoints();
      cards[firstIndex] = cards[firstIndex].copyWith(isMatched: true);
      cards[index] = cards[index].copyWith(isMatched: true);
    } else {
      _gameSessionService.increaseMissAttempts();
      await Future.delayed(const Duration(seconds: 1));
      cards[firstIndex] = cards[firstIndex].copyWith(isFlipped: false);
      cards[index] = cards[index].copyWith(isFlipped: false);
    }

    final won = cards.every((card) => card.isMatched);
    if (won) {
      await _gameSessionService.sessionEnd();
    }
    emit(
      state.copyWith(
        cards: cards,
        isBusy: false,
        firstFlippedIndex: -1,
        hasWon: won,
        score: _gameSessionService.session?.score,
        missed: _gameSessionService.session?.missed,
      ),
    );
  }
}
