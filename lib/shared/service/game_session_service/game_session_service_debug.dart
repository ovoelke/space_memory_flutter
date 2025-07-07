import 'package:space_memory_flutter/shared/model/highscore.dart';
import 'package:space_memory_flutter/shared/service/game_session_service/game_session_service.dart';

/// A mock implementation of [GameSessionService] for debug or development mode.
///
/// This service simulates delayed API interactions and stores highscore data in memory.
/// It provides fake highscore entries and allows for local session tracking
/// without persistent storage or real backend integration.
///
/// Useful for testing UI and logic without needing a real backend.
class GameSessionServiceDebug implements GameSessionService {
  /// Simulated delay for API calls (in milliseconds).
  static const debugApiDelayMilliseconds = 1200;

  /// The debug player's display name.
  final debugPlayerName = 'You';

  /// A fixed UUID used to represent the debug player.
  final debugPlayerId = 'ce152b74-26e1-4797-84d2-5180774712aa';

  Highscore? _session;
  List<Highscore> _highscores = [];

  /// The currently active session, or `null` if no session is active.
  @override
  Highscore? get session => _session;

  /// The list of highscores stored in memory.
  @override
  List<Highscore> get highscores => _highscores;

  /// Private constructor – use [create] to instantiate.
  GameSessionServiceDebug._();

  /// Creates and initializes a new debug service instance with fake data.
  static Future<GameSessionServiceDebug> create() async {
    final instance = GameSessionServiceDebug._();

    final now = DateTime.now();
    instance._highscores = [
      Highscore(
        'Ali Bi',
        'ae55049c-debb-4131-925b-da1539fdd72c',
        now.subtract(Duration(hours: 1, minutes: 2)),
        score: 100,
        sessionEnd: DateTime.now().subtract(Duration(hours: 1)),
        missed: 3,
      ),
      Highscore(
        'Ben Zin',
        'ae55049c-debb-4131-925b-da1539fdd72c',
        now.subtract(Duration(hours: 2, minutes: 2)),
        score: 200,
        sessionEnd: DateTime.now().subtract(Duration(hours: 2)),
        missed: 2,
      ),
      Highscore(
        'Chris Tus',
        'c068bcd8-7cdb-4704-aacf-806f842acb60',
        now.subtract(Duration(hours: 3, minutes: 2)),
        score: 300,
        sessionEnd: DateTime.now().subtract(Duration(hours: 3)),
        missed: 2,
      ),
    ];

    return instance;
  }

  /// Simulates a refresh of scores, e.g., from a remote API.
  @override
  Future<void> refreshScores() async => await Future.delayed(
    const Duration(milliseconds: debugApiDelayMilliseconds),
  );

  /// Ends the current session and adds it to the highscores list.
  ///
  /// Throws if no session exists.
  @override
  Future<void> sessionEnd() async {
    await Future.delayed(
      const Duration(milliseconds: debugApiDelayMilliseconds),
    );
    if (_session == null) {
      throw Exception('There is no session to end.');
    }
    _session = _session!.copyWith(sessionEnd: DateTime.now());

    _highscores.add(_session!);
  }

  /// Starts a new session for the debug player.
  ///
  /// Existing session will be replaced.
  @override
  Future<void> sessionStart() async {
    await Future.delayed(
      const Duration(milliseconds: debugApiDelayMilliseconds),
    );
    _session = Highscore(debugPlayerName, debugPlayerId, DateTime.now());
  }

  /// Updates the current session by adding missed attempts.
  ///
  /// Throws if no session exists.
  @override
  Highscore increaseMissAttempts() {
    if (_session == null) {
      throw Exception('There is no session to update.');
    }
    return _session = _session!.copyWith(missed: _session!.missed + 1);
  }

  /// Updates the current session by adding points, depending on attempts.
  /// Amount of missed attempts will be reduced to zero.
  ///
  /// Throws if no session exists.
  @override
  Highscore increaseSessionPoints() {
    if (_session == null) {
      throw Exception('There is no session to update.');
    }
    int score = _session!.score;
    if (_session!.missed == 0) {
      score += 50;
    } else if (_session!.missed == 1) {
      score += 25;
    } else if (_session!.missed == 2) {
      score += 15;
    } else {
      score += 5;
    }
    return _session = _session!.copyWith(missed: 0, score: score);
  }
}
