import "package:flutter_dotenv/flutter_dotenv.dart";

class ApiConfig {
  static String get emotionServiceApi =>
      dotenv.env["FLUTTER_APP_EMOTION_SERVICE"] ?? "";

  static String get recommendationServiceApi =>
      dotenv.env["FLUTTER_APP_RECOMMENDATION_SERVICE"] ?? "";
}
