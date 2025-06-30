import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              Text('test'),
              ElevatedButton(
                key: const Key("button_start"),
                onPressed: () => onStartPressed(context),
                child: Text(tr('home.start')),
              ),
              ElevatedButton(
                key: const Key("button_highscores"),
                onPressed: () => onHighscorePressed,
                child: Text(tr('home.highscores')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onStartPressed(BuildContext context) {
    showDialog<GameDifficulty>(
      context: context,
      builder:
          (BuildContext context) => SimpleDialog(
            title: Text(tr('difficulty.dialog_title')),
            children:
                GameDifficulty.values
                    .map(
                      (difficulty) => SimpleDialogOption(
                        onPressed:
                            (() => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          MemoryGame(difficulty: difficulty),
                                ),
                              ),
                            }),
                        child: Text(difficulty.label),
                      ),
                    )
                    .toList(),
          ),
    );
  }

  void startGameWith(BuildContext context, GameDifficulty difficulty) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MemoryGame(difficulty: difficulty),
        ),
      );

  void onHighscorePressed() {
    if (kDebugMode) {
      print('TODO: implement!');
    }
  }
}
