import 'package:sentigo/models/emotion.dart';
import 'package:sentigo/models/recommendation.dart';

class EmotionError {
  final String error;
  final bool isError;

  EmotionError({required this.error, required this.isError});

  factory EmotionError.fromJson(EmotionResponse json) {
    return EmotionError(
      error: json.message,
      isError: !json.success ,
    );
  }
}

class RecommendationError {
  final String error;
  final bool isError;

  RecommendationError({required this.error, required this.isError});

  factory RecommendationError.fromJson(RecommendationResponse json) {
    return RecommendationError(
      error: json.message,
      isError: !json.success ,
    );
  }
}
