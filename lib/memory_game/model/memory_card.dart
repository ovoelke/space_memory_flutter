class MemoryCard {
  final String imageAssetPath;
  final bool isFlipped;
  final bool isMatched;

  MemoryCard({
    required this.imageAssetPath,
    this.isFlipped = false,
    this.isMatched = false,
  });

  MemoryCard copyWith({
    String? imageAssetPath,
    bool? isFlipped,
    bool? isMatched,
  }) {
    return MemoryCard(
      imageAssetPath: imageAssetPath ?? this.imageAssetPath,
      isFlipped: isFlipped ?? this.isFlipped,
      isMatched: isMatched ?? this.isMatched,
    );
  }
}