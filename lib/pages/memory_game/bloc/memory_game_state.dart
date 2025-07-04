import 'package:space_memory_flutter/pages/memory_game/model/memory_card.dart';

class MemoryGameState {
  final List<MemoryCard> cards;
  final bool isBusy;
  final bool hasWon;
  final int? firstFlippedIndex;

  MemoryGameState({
    required this.cards,
    this.isBusy = false,
    this.hasWon = false,
    this.firstFlippedIndex,
  });

  MemoryGameState copyWith({
    List<MemoryCard>? cards,
    bool? isBusy,
    bool? hasWon,
    int? firstFlippedIndex,
  }) {
    return MemoryGameState(
      cards: cards ?? this.cards,
      isBusy: isBusy ?? this.isBusy,
      hasWon: hasWon ?? this.hasWon,
      firstFlippedIndex: firstFlippedIndex ?? this.firstFlippedIndex,
    );
  }
}
