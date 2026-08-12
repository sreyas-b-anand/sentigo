
class EmotionResponse {
  final String message;
  final bool success;
  final String emotion;
  final double confidence;
  final bool noEmotion;

  EmotionResponse({
    required this.confidence,
    required this.success,
    required this.noEmotion,
    required this.message,
    required this.emotion,
  });

  factory EmotionResponse.fromJson(Map<String, dynamic> json) {
    return EmotionResponse(
      confidence: (json["confidence"] as num).toDouble(),
      success: json["success"],
      noEmotion: json["no_emotion"],
      message: json["message"],
      emotion: json["emotion"],
    );
  }
}
