import 'package:easy_localization/easy_localization.dart';

enum GameDifficulty { easy, medium, hard }

extension GameDifficultyExtension on GameDifficulty {
  String get label {
    return switch (this) {
      GameDifficulty.easy => tr('shared.difficulty.easy'),
      GameDifficulty.medium => tr('shared.difficulty.medium'),
      GameDifficulty.hard => tr('shared.difficulty.hard'),
    };
  }
}
