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
    this.homeOdds,
    this.awayOdds,
    this.drawOdds,
  });

  factory MatchGame.fromJson(Map<String, dynamic> json) {
    final home = json['HomeTeam'] ??
        json['HomeTeamName'] ??
        json['Home'] ??
        "Home";

    final away = json['AwayTeam'] ??
        json['AwayTeamName'] ??
        json['Away'] ??
        "Away";

    final time = DateTime.tryParse(
            json['Day'] ??
            json['DateTime'] ??
            json['StartTime'] ??
            "") ??
        DateTime.now();

    final cid = json['CompetitionId'] ??
        json['LeagueId'] ??
        json['Season'] ??
        null;

    double? convertOdds(dynamic v) {
      if (v == null) return null;
      final ml = double.tryParse(v.toString());
      if (ml == null) return null;

      if (ml < 0) {
        return 1 + (100 / ml.abs());
      } else {
        return 1 + (ml / 100);
      }
    }

    return MatchGame(
      gameId: json['GameId'] ?? json['FixtureId'],
      homeTeam: home,
      awayTeam: away,
      startTime: time,
      competitionId: cid,
      homeOdds: convertOdds(json['HomeMoneyLine']),
      awayOdds: convertOdds(json['AwayMoneyLine']),
      drawOdds: convertOdds(json['DrawMoneyLine']),
    );
  }
}
