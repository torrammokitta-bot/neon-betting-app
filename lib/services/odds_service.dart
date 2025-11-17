class OddsService {
  /// Convert American odds to Decimal odds.
  double? toDecimal(dynamic value) {
    if (value == null) return null;

    double? ml = double.tryParse(value.toString());
    if (ml == null) return null;

    if (ml < 0) {
      return 1 + (100 / ml.abs());
    } else {
      return 1 + (ml / 100);
    }
  }

  /// Calculate implied probability from decimal odds.
  double probability(double decimalOdds) {
    return (1 / decimalOdds) * 100;
  }
}
