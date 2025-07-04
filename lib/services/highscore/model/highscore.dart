class Highscore {
  final String playerName;
  final String playerId;
  final DateTime sessionStart;
  final int score;
  final int incorrectCount;
  final DateTime? sessionEnd;

  Highscore(
    this.playerName,
    this.playerId,
    this.sessionStart, {
    this.sessionEnd,
    this.score = 0,
    this.incorrectCount = 0,
  });

  @override
  bool operator ==(Object other) =>
      other is Highscore && other.playerId == playerId;

  @override
  int get hashCode => playerId.hashCode;

  Highscore copyWith({
    String? playerName,
    String? playerId,
    DateTime? sessionStart,
    int? score,
    int? incorrectCount,
    DateTime? sessionEnd,
  }) {
    return Highscore(
      playerName ?? this.playerName,
      playerId ?? this.playerId,
      sessionStart ?? this.sessionStart,
      score: score ?? this.score,
      incorrectCount: incorrectCount ?? this.incorrectCount,
      sessionEnd: sessionEnd ?? this.sessionEnd,
    );
  }

  Map<String, dynamic> toJson() => {
    'playerName': playerName,
    'playerId': playerId,
    'sessionStart': sessionStart.toIso8601String(),
    'score': score,
    'incorrectCount': incorrectCount,
    'sessionEnd': sessionEnd?.toIso8601String(),
  };

  factory Highscore.fromJson(Map<String, dynamic> json) => Highscore(
    json['playerName'],
    json['playerId'],
    DateTime.parse(json['sessionStart']),
    score: json['score'],
    incorrectCount: json['incorrectCount'],
    sessionEnd:
        json['sessionEnd'] != null ? DateTime.parse(json['sessionEnd']) : null,
  );
}
