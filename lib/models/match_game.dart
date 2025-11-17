class MatchGame {
  final int? gameId;
  final String homeTeam;
  final String awayTeam;
  final DateTime startTime;
  final int? competitionId;
  final double? homeOdds;
  final double? awayOdds;
  final double? drawOdds;

  MatchGame({
    required this.gameId,
    required this.homeTeam,
    required this.awayTeam,
    required this.startTime,
    required this.competitionId,
    required this.homeOdds,
    required this.awayOdds,
    required this.drawOdds,
  });

  factory MatchGame.fromJson(Map<String, dynamic> json) {
    // SAFE string extract
    String safeString(dynamic v, String fallback) {
      if (v == null) return fallback;
      if (v is String && v.trim().isNotEmpty) return v;
      return fallback;
    }

    // SAFE int extract
    int? safeInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      return int.tryParse(v.toString());
    }

    // SAFE date parsing
    DateTime safeDate(dynamic v) {
      if (v == null) return DateTime.now();
      try {
        return DateTime.parse(v);
      } catch (_) {
        return DateTime.now();
      }
    }

    // Convert American odds → Decimal
    double? convertOdds(dynamic v) {
      if (v == null) return null;
      double? ml = double.tryParse(v.toString());
      if (ml == null) return null;

      if (ml < 0) {
        return 1 + (100 / ml.abs());
      } else {
        return 1 + (ml / 100);
      }
    }

    return MatchGame(
      gameId: safeInt(json['GameId']) ?? safeInt(json['FixtureId']),
      homeTeam: safeString(
          json['HomeTeam'] ??
              json['HomeTeamName'] ??
              json['Home'],
          "Home"),
      awayTeam: safeString(
          json['AwayTeam'] ??
              json['AwayTeamName'] ??
              json['Away'],
          "Away"),
      startTime: safeDate(
        json['Day'] ??
            json['DateTime'] ??
            json['StartTime'],
      ),
      competitionId: safeInt(
        json['CompetitionId'] ??
            json['LeagueId'] ??
            json['Season'],
      ),
      homeOdds: convertOdds(json['HomeMoneyLine']),
      awayOdds: convertOdds(json['AwayMoneyLine']),
      drawOdds: convertOdds(json['DrawMoneyLine']),
    );
  }
}
