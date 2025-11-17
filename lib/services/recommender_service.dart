import '../models/match_game.dart';
import 'odds_service.dart';

class RecommenderService {
  static final RecommenderService instance = RecommenderService._internal();

  RecommenderService._internal();

  final OddsService oddsService = OddsService();

  /// Simple recommendation based on best odds & safer side
  String recommend(MatchGame g) {
    double? home = g.homeOdds;
    double? away = g.awayOdds;

    if (home == null || away == null) {
      return "Not enough data";
    }

    // Lower decimal odds = higher chance of winning
    if (home < away) {
      return "Recommendation: ${g.homeTeam} WIN (safer side)";
    } else {
      return "Recommendation: ${g.awayTeam} WIN (safer side)";
    }
  }

  /// Build a simple Ultra-Safe ACCA (lowest odds = safer picks)
  List<MatchGame> buildUltraSafeAcca(List<MatchGame> matches) {
    List<MatchGame> safe = [];

    matches.sort((a, b) {
      double aBest = _bestOdds(a);
      double bBest = _bestOdds(b);
      return aBest.compareTo(bBest);
    });

    // Take first 3 safest picks
    for (int i = 0; i < matches.length && safe.length < 3; i++) {
      safe.add(matches[i]);
    }

    return safe;
  }

  /// Build Medium ACCA (moderate picks)
  List<MatchGame> buildMediumAcca(List<MatchGame> matches) {
    List<MatchGame> medium = [];

    matches.sort((a, b) {
      double aMid = _middleOdds(a);
      double bMid = _middleOdds(b);
      return aMid.compareTo(bMid);
    });

    for (int i = 0; i < matches.length && medium.length < 3; i++) {
      medium.add(matches[i]);
    }

    return medium;
  }

  /// Build High-Risk ACCA (higher odds)
  List<MatchGame> buildHighRiskAcca(List<MatchGame> matches) {
    List<MatchGame> risky = [];

    matches.sort((a, b) {
      double aWorst = _worstOdds(a);
      double bWorst = _worstOdds(b);
      return bWorst.compareTo(aWorst); // highest odds first
    });

    for (int i = 0; i < matches.length && risky.length < 3; i++) {
      risky.add(matches[i]);
    }

    return risky;
  }

  /// Helper – return the lowest (safest) odds
  double _bestOdds(MatchGame m) {
    return [
      m.homeOdds ?? 99,
      m.awayOdds ?? 99,
      m.drawOdds ?? 99
    ].reduce((a, b) => a < b ? a : b);
  }

  /// Helper – return middle odds (medium safety)
  double _middleOdds(MatchGame m) {
    List<double> o = [
      m.homeOdds ?? 99,
      m.awayOdds ?? 99,
      m.drawOdds ?? 99
    ];
    o.sort();
    return o[1]; // middle
  }

  /// Helper – return highest odds (risky)
  double _worstOdds(MatchGame m) {
    return [
      m.homeOdds ?? 0,
      m.awayOdds ?? 0,
      m.drawOdds ?? 0
    ].reduce((a, b) => a > b ? a : b);
  }
}
