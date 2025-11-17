import 'dart:convert';
import 'package:http/http.dart' as http;

class SportsDataService {
  static String apiKey = "YOUR_API_KEY_HERE";

  Future<List<dynamic>> loadMatchesByDate(String date) async {
    final url =
        "https://api.sportsdata.io/v3/soccer/scores/json/GamesByDate/$date?key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }
}
