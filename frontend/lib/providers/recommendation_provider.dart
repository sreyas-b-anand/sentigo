import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentigo/models/recommendation.dart';

class RecommendationNotifier extends Notifier<RecommendationResponse> {
  @override
  RecommendationResponse build() {
    return RecommendationResponse(
      message: '',
      success: false,
      recommendations: '',
    );
  }

  void setRecommendation(RecommendationResponse response) {
    state = response;
  }
}

final recommendationProvider =
    NotifierProvider<RecommendationNotifier, RecommendationResponse>(() {
      return RecommendationNotifier();
    });
