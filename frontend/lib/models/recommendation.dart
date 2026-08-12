class RecommendationResponse {
  final String recommendations;
  final String message;
  final bool success;

  RecommendationResponse({
    required this.recommendations,
    required this.message,
    required this.success,
  });

  factory RecommendationResponse.fromJson(Map<String, dynamic> json) {
    return RecommendationResponse(
      recommendations: json["recommendations"],
      message: json["message"],
      success: json["success"],
    );
  }
}
