import 'package:easy_localization/easy_localization.dart';

enum GameDifficulty { easy, medium, hard }

extension GameDifficultyExtension on GameDifficulty {
  String get label {
    return switch (this) {
      GameDifficulty.easy => tr('difficulty.easy'),
      GameDifficulty.medium => tr('difficulty.medium'),
      GameDifficulty.hard => tr('difficulty.hard'),
    };
  }
}
