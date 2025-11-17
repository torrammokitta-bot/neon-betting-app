import '../models/match_game.dart';

class RecommenderService {
  // Safe probability calculator
  double safeProb(double? odds) {
    if (odds == null || odds <= 1.0) return 0.0;
    return (1 / odds).clamp(0.0, 1.0);
  }

  // Returns best recommended bet type
  Map<String, dynamic> recommend(MatchGame match) {
    double homeProb = safeProb(match.homeOdds);
    double awayProb = safeProb(match.awayOdds);
    double drawProb = safeProb(match.drawOdds);

    // Prevent NaN
    homeProb = homeProb.isNaN ? 0 : homeProb;
    awayProb = awayProb.isNaN ? 0 : awayProb;
    drawProb = drawProb.isNaN ? 0 : drawProb;

    double maxProb = [homeProb, awayProb, drawProb].reduce((a, b) => a > b ? a : b);

    String pick = "";
    if (maxProb == homeProb) pick = "Home Win";
    else if (maxProb == awayProb) pick = "Away Win";
    else pick = "Draw";

    return {
      "pick": pick,
      "probability": (maxProb * 100).clamp(0, 100),
      "odds": _selectOdds(match, pick),
    };
  }

  double? _selectOdds(MatchGame match, String pick) {
    if (pick == "Home Win") return match.homeOdds;
    if (pick == "Away Win") return match.awayOdds;
    if (pick == "Draw") return match.drawOdds;
    return null;
  }
}
