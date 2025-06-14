import '../model/memory_card.dart';

class MemoryGameState {
  final List<MemoryCard> cards;
  final bool isBusy;
  final int? firstFlippedIndex;

  MemoryGameState({
    required this.cards,
    this.isBusy = false,
    this.firstFlippedIndex,
  });

  MemoryGameState copyWith({
    List<MemoryCard>? cards,
    bool? isBusy,
    int? firstFlippedIndex,
  }) {
    return MemoryGameState(
      cards: cards ?? this.cards,
      isBusy: isBusy ?? this.isBusy,
      firstFlippedIndex: firstFlippedIndex ?? this.firstFlippedIndex,
    );
  }
}