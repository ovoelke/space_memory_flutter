import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_memory_flutter/memory_game/bloc/memory_game_bloc.dart';
import 'package:space_memory_flutter/memory_game/bloc/memory_game_event.dart';
import 'package:space_memory_flutter/memory_game/bloc/memory_game_state.dart';

class MemoryGame extends StatelessWidget {
  const MemoryGame({super.key});

  @override
  Widget build(BuildContext context) {
    const cardImages = [
      'assets/images/ic_tile_a.png',
      'assets/images/ic_tile_b.png',
      'assets/images/ic_tile_c.png',
      'assets/images/ic_tile_d.png',
      'assets/images/ic_tile_e.png',
      'assets/images/ic_tile_f.png',
      'assets/images/ic_tile_g.png',
      'assets/images/ic_tile_h.png',
      'assets/images/ic_tile_i.png',
    ];
    return BlocProvider(
      create: (_) => MemoryGameBloc()..add(InitializeGame(cardImages)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Memory"),
        ),
        body: BlocBuilder<MemoryGameBloc, MemoryGameState>(
          builder: (context, state) {
            final cards = state.cards;

            if (cards.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

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
                        color: card.isMatched ? Colors.grey.shade300 : Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Center(
                        child: card.isFlipped || card.isMatched
                            ? Image.asset(card.imageAssetPath)
                            : const Icon(Icons.question_mark, size: 32),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
