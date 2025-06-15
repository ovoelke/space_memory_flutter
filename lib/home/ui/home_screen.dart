import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:space_memory_flutter/memory_game/ui/memory_game_screen.dart';
import 'package:space_memory_flutter/shared/enum/game_difficulty.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(tr('title')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [..._buildButtons(context)],
        ),
      ),
    );
  }
}

List<Widget> _buildButtons(BuildContext context) {
  return GameDifficulty.values
      .map(
        (difficulty) => ElevatedButton(
          onPressed:
              (() => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemoryGame(difficulty: difficulty),
                  ),
                ),
              }),
          child: Text(difficulty.label),
        ),
      )
      .toList();
}
