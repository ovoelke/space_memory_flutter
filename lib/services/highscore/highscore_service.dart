import 'package:space_memory_flutter/services/highscore/model/highscore.dart';

abstract class HighscoreService {
  Highscore? get session;

  List<Highscore> get highscores;

  Future<void> refreshScores();

  Future<void> sessionEnd();

  Future<void> sessionStart();

  Future<void> sessionUpdate(int scoreIncrease, int incorrectCountIncrease);
}
