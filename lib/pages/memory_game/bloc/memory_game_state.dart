import 'package:space_memory_flutter/pages/memory_game/model/memory_card.dart';

class MemoryGameState {
  final List<MemoryCard> cards;
  final bool isBusy;
  final bool hasWon;
  final int? firstFlippedIndex;
  final int? score;
  final int? missed;

  MemoryGameState({
    required this.cards,
    this.isBusy = false,
    this.hasWon = false,
    this.firstFlippedIndex,
    this.score = 0,
    this.missed = 0,
  });

  MemoryGameState copyWith({
    List<MemoryCard>? cards,
    bool? isBusy,
    bool? hasWon,
    int? firstFlippedIndex,
    int? score,
    int? missed,
  }) {
    return MemoryGameState(
      cards: cards ?? this.cards,
      isBusy: isBusy ?? this.isBusy,
      hasWon: hasWon ?? this.hasWon,
      firstFlippedIndex: firstFlippedIndex ?? this.firstFlippedIndex,
      score: score ?? this.score,
      missed: missed ?? this.missed,
    );
  }
}
