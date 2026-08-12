import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sentigo/config/api_config.dart';
import 'package:sentigo/models/emotion.dart';

class EmotionServices {
  Future<EmotionResponse> getEmotion(String text) async {
    try {
      final emotionApiEndpoint = "${ApiConfig.emotionServiceApi}/get_emotion";

      final emotionUrl = Uri.parse(emotionApiEndpoint);

      final response = await http.post(
        emotionUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}),
      );

      if (response.statusCode != 200) {
        throw Exception('An API error occured!');
      }

      final data = jsonDecode(response.body);

      return EmotionResponse.fromJson(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
