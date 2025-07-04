import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_memory_flutter/pages/memory_game/model/memory_card.dart';
import 'package:space_memory_flutter/pages/memory_game/bloc/memory_game_event.dart';
import 'package:space_memory_flutter/pages/memory_game/bloc/memory_game_state.dart';

class MemoryGameBloc extends Bloc<MemoryGameEvent, MemoryGameState> {
  MemoryGameBloc() : super(MemoryGameState(cards: [])) {
    on<InitializeGame>(_onInitializeGame);
    on<FlipCard>(_onFlipCard);
  }

  void _onInitializeGame(InitializeGame event, Emitter<MemoryGameState> emit) {
    final images = [...event.images, ...event.images]..shuffle();
    final cards =
        images.map((path) => MemoryCard(imageAssetPath: path)).toList();
    emit(MemoryGameState(cards: cards));
  }

  Future<void> _onFlipCard(FlipCard event, Emitter<MemoryGameState> emit) async {
    final index = event.index;
    final cards = List<MemoryCard>.from(state.cards);

    if (cards[index].isFlipped || cards[index].isMatched || state.isBusy) {
      return;
    }

    cards[index] = cards[index].copyWith(isFlipped: true);

    if (state.firstFlippedIndex == null) {
      emit(state.copyWith(cards: cards, firstFlippedIndex: index));
    } else {
      emit(state.copyWith(cards: cards, isBusy: true));

      final firstIndex = state.firstFlippedIndex!;
      final match =
          cards[firstIndex].imageAssetPath == cards[index].imageAssetPath;

      await Future.delayed(const Duration(seconds: 1));

      if (match) {
        cards[firstIndex] = cards[firstIndex].copyWith(isMatched: true);
        cards[index] = cards[index].copyWith(isMatched: true);
      } else {
        cards[firstIndex] = cards[firstIndex].copyWith(isFlipped: false);
        cards[index] = cards[index].copyWith(isFlipped: false);
      }

      final allMatched = cards.every((card) => card.isMatched);

      emit(MemoryGameState(cards: cards, hasWon: allMatched));
    }
  }
}
