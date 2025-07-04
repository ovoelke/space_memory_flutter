import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:space_memory_flutter/pages/memory_game/bloc/memory_game_bloc.dart';
import 'package:space_memory_flutter/pages/memory_game/bloc/memory_game_event.dart';
import 'package:space_memory_flutter/pages/memory_game/bloc/memory_game_state.dart';

void main() {
  group('MemoryGameBloc', () {
    final imagePaths = ['a.png', 'b.png', 'c.png'];

    blocTest<MemoryGameBloc, MemoryGameState>(
      'Initializes the game with doubled and shuffled cards',
      build: () => MemoryGameBloc(),
      act: (bloc) => bloc.add(InitializeGame(imagePaths)),
      verify: (bloc) {
        expect(bloc.state.cards.length, 6);
        expect(
          imagePaths.every(
            (img) =>
                bloc.state.cards.where((c) => c.imageAssetPath == img).length ==
                2,
          ),
          isTrue,
        );
      },
    );

    blocTest<MemoryGameBloc, MemoryGameState>(
      'Matches two identical cards correctly',
      build: () => MemoryGameBloc(),
      act: (bloc) async {
        final images = ['a.png'];
        bloc.add(InitializeGame(images));
        await Future.delayed(Duration.zero);

        final firstIndex = 0;
        final secondIndex = 1;
        bloc.add(FlipCard(firstIndex));
        await Future.delayed(Duration.zero);
        bloc.add(FlipCard(secondIndex));
        await Future.delayed(Duration(seconds: 1));
      },
      wait: const Duration(seconds: 2),
      verify: (bloc) {
        final cards = bloc.state.cards;
        expect(cards[0].isMatched, isTrue);
        expect(cards[1].isMatched, isTrue);
      },
    );
  });
}
