class GameHistory {
  final String id;
  final String opponentName;
  final String category;
  final DateTime playedAt;
  final bool isWin;
  final int myScore;
  final int opponentScore;
  final String? result;

  GameHistory({
    required this.id,
    required this.opponentName,
    required this.category,
    required this.playedAt,
    required this.isWin,
    required this.myScore,
    required this.opponentScore,
    this.result,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'opponentName': opponentName,
      'category': category,
      'playedAt': playedAt.toIso8601String(),
      'isWin': isWin,
      'myScore': myScore,
      'opponentScore': opponentScore,
      'result': result,
    };
  }

  factory GameHistory.fromJson(Map<String, dynamic> json) {
    return GameHistory(
      id: json['id'] as String,
      opponentName: json['opponentName'] as String,
      category: json['category'] as String,
      playedAt: DateTime.parse(json['playedAt'] as String),
      isWin: json['isWin'] as bool,
      myScore: (json['myScore'] as num).toInt(),
      opponentScore: (json['opponentScore'] as num).toInt(),
      result: json['result'] as String?,
    );
  }
}
