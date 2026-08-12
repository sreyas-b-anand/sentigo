import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sentigo/config/api_config.dart';
import 'package:sentigo/models/recommendation.dart';

class RecommendationServices {
  Future<RecommendationResponse> getRecommendation(String emotion) async {
    try {
      final recommendationtionApiEndpoint =
          "${ApiConfig.recommendationServiceApi}/get_recommendation";

      final recommendationUrl = Uri.parse(recommendationtionApiEndpoint);

      final response = await http.post(
        recommendationUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'emotion': emotion}),
      );

      if (response.statusCode != 200) {
        throw Exception('An API error occured!');
      }

      final data = jsonDecode(response.body);

      return RecommendationResponse.fromJson(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
