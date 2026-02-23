class UserStats {
  final int victories;
  final int inProgress;
  final double winRate;
  final int totalGames;
  final int totalWins;
  final int totalLosses;

  UserStats({
    this.victories = 0,
    this.inProgress = 0,
    this.winRate = 0.0,
    this.totalGames = 0,
    this.totalWins = 0,
    this.totalLosses = 0,
  });

  UserStats copyWith({
    int? victories,
    int? inProgress,
    double? winRate,
    int? totalGames,
    int? totalWins,
    int? totalLosses,
  }) {
    return UserStats(
      victories: victories ?? this.victories,
      inProgress: inProgress ?? this.inProgress,
      winRate: winRate ?? this.winRate,
      totalGames: totalGames ?? this.totalGames,
      totalWins: totalWins ?? this.totalWins,
      totalLosses: totalLosses ?? this.totalLosses,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'victories': victories,
      'inProgress': inProgress,
      'winRate': winRate,
      'totalGames': totalGames,
      'totalWins': totalWins,
      'totalLosses': totalLosses,
    };
  }

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      victories: (json['victories'] as num?)?.toInt() ?? 0,
      inProgress: (json['inProgress'] as num?)?.toInt() ?? 0,
      winRate: (json['winRate'] as num?)?.toDouble() ?? 0.0,
      totalGames: (json['totalGames'] as num?)?.toInt() ?? 0,
      totalWins: (json['totalWins'] as num?)?.toInt() ?? 0,
      totalLosses: (json['totalLosses'] as num?)?.toInt() ?? 0,
    );
  }
}
