import 'package:space_memory_flutter/shared/model/highscore.dart';

abstract class GameSessionService {
  Highscore? get session;

  List<Highscore> get highscores;

  Future<void> refreshScores();

  Future<void> sessionEnd();

  Future<void> sessionStart();

  Highscore increaseSessionPoints();

  Highscore increaseMissAttempts();
}
