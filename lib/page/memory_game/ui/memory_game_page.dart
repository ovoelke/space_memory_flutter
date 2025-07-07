import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_memory_flutter/page/memory_game/bloc/memory_game_bloc.dart';
import 'package:space_memory_flutter/page/memory_game/bloc/memory_game_event.dart';
import 'package:space_memory_flutter/page/memory_game/bloc/memory_game_state.dart';
import 'package:space_memory_flutter/shared/enum/game_difficulty.dart';
import 'package:space_memory_flutter/shared/ui/confetti_explosion.dart';

class MemoryGamePage extends StatelessWidget {
  const MemoryGamePage({super.key, required this.difficulty});

  final GameDifficulty difficulty;

  final String maskCard = 'assets/images/ic_tile_mask.png';

  List<String> get cards {
    return switch (difficulty) {
      GameDifficulty.easy => [
        'assets/images/ic_tile_a.png',
        'assets/images/ic_tile_b.png',
      ],
      GameDifficulty.medium => [
        'assets/images/ic_tile_a.png',
        'assets/images/ic_tile_b.png',
        'assets/images/ic_tile_c.png',
        'assets/images/ic_tile_d.png',
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
          title: Text(tr('title')),
        ),
        body: BlocBuilder<MemoryGameBloc, MemoryGameState>(
          builder: (context, state) {
            final cards = state.cards;
            if (state.hasWon) {
              return Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ConfettiExplosion(),
                      Text('memory_game.won').tr(),
                    ],
                  ),
                ),
              );
            } else {
              return Stack(
                children: [
                  if (state.isBusy) Center(child: CircularProgressIndicator()),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        'memory_game.points',
                      ).tr(namedArgs: {'score': '${state.score}'}),
                      Spacer(),
                      Text(
                        'memory_game.attempts',
                      ).tr(namedArgs: {'missed': '${state.missed}'}),
                      Spacer(),
                    ],
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.all(48),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
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
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
