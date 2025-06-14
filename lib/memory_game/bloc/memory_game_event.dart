abstract class MemoryGameEvent {}

class InitializeGame extends MemoryGameEvent {
  final List<String> images;
  InitializeGame(this.images);
}

class FlipCard extends MemoryGameEvent {
  final int index;
  FlipCard(this.index);
}