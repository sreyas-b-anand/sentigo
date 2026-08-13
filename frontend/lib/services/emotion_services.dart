import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sentigo/config/api_config.dart';
import 'package:sentigo/models/emotion.dart';

class EmotionServices {
  Future<EmotionResponse> getEmotion(String text) async {
    final emotionUrl = Uri.parse("${ApiConfig.emotionServiceApi}/get_emotion");
    if (text.isEmpty) {
      return EmotionResponse(
        success: false,
        message: 'Provide some input.',
        emotion: '',
        confidence: 0,
        noEmotion: false,
      );
    }
    final response = await http.post(
      emotionUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode != 200) {
      return EmotionResponse(
        success: false,
        message: 'Unable to analyze your input. Please try again.',
        emotion: '',
        confidence: 0,
        noEmotion: false,
      );
    }

    try {
      final data = jsonDecode(response.body);
      return EmotionResponse.fromJson(data);
    } catch (_) {
      return EmotionResponse(
        success: false,
        message: 'The server returned an invalid response.',
        emotion: '',
        confidence: 0,
        noEmotion: false,
      );
    }
  }
}
