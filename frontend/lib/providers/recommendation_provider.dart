import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecommendationNotifier extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void setRecommendation(String message) {
    state = message;
  }
}

final recommendationNotifier = NotifierProvider<RecommendationNotifier, String>(() {
  return RecommendationNotifier();
});
