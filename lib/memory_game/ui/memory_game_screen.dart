import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_memory_flutter/memory_game/bloc/memory_game_bloc.dart';
import 'package:space_memory_flutter/memory_game/bloc/memory_game_event.dart';
import 'package:space_memory_flutter/memory_game/bloc/memory_game_state.dart';
import 'package:space_memory_flutter/shared/enum/game_difficulty.dart';
import 'package:space_memory_flutter/shared/ui/confetti_explosion.dart';

class MemoryGame extends StatelessWidget {
  const MemoryGame({super.key, required this.difficulty});

  final GameDifficulty difficulty;

  final String maskCard = 'assets/images/ic_tile_mask.png';

  List<String> get cards {
    return switch (difficulty) {
      GameDifficulty.easy => [
        'assets/images/ic_tile_a.png',
        'assets/images/ic_tile_b.png',
        'assets/images/ic_tile_c.png',
      ],
      GameDifficulty.medium => [
        'assets/images/ic_tile_a.png',
        'assets/images/ic_tile_b.png',
        'assets/images/ic_tile_c.png',
        'assets/images/ic_tile_d.png',
        'assets/images/ic_tile_e.png',
      ],
      GameDifficulty.hard => [
        'assets/images/ic_tile_a.png',
        'assets/images/ic_tile_b.png',
        'assets/images/ic_tile_c.png',
        'assets/images/ic_tile_d.png',
        'assets/images/ic_tile_e.png',
        'assets/images/ic_tile_f.png',
        'assets/images/ic_tile_g.png',
        'assets/images/ic_tile_h.png',
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MemoryGameBloc()..add(InitializeGame(cards)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Memory"),
        ),
        body: BlocBuilder<MemoryGameBloc, MemoryGameState>(
          builder: (context, state) {
            final cards = state.cards;
            if (state.hasWon) {
              return Stack(children: [ConfettiExplosion(), Text('Won!')]);
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onTap: () {
                        context.read<MemoryGameBloc>().add(FlipCard(index));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              card.isMatched
                                  ? Colors.grey.shade300
                                  : Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Center(
                          child:
                              card.isFlipped || card.isMatched
                                  ? Image.asset(card.imageAssetPath)
                                  : Image.asset(maskCard),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
