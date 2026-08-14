import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sentigo/models/emotion.dart';
import 'package:sentigo/providers/loading_provider.dart';
import 'package:sentigo/providers/recommendation_provider.dart';
import 'package:sentigo/services/emotion_services.dart';
import 'package:sentigo/services/recommendation_services.dart';

class EmotionNotifier extends Notifier<EmotionResponse> {
  final EmotionServices _emotionService = EmotionServices();
  final RecommendationServices _recommendationService =
      RecommendationServices();

  @override
  EmotionResponse build() {
    return EmotionResponse(
      success: false,
      emotion: '',
      confidence: 0,
      noEmotion: false,
      message: '',
    );
  }

  Future<void> analyze(String text) async {
    if (text.trim().isEmpty) return;

    ref.read(loadingProvider.notifier).setLoading(true);

    try {
      final emotionResponse = await _emotionService.getEmotion(text.trim());

      state = emotionResponse;

      if (emotionResponse.success && !emotionResponse.noEmotion) {
        final recommendationResponse = await _recommendationService
            .getRecommendation(emotionResponse.emotion);

        ref
            .read(recommendationProvider.notifier)
            .setRecommendation(recommendationResponse);
      }
    } catch (e) {
      // print('Emotion API error: $e');

      state = EmotionResponse(
        success: false,
        emotion: '',
        confidence: 0,
        noEmotion: false,
        message: e.toString(),
      );
    } finally {
      ref.read(loadingProvider.notifier).setLoading(false);
    }
  }
}

final emotionProvider = NotifierProvider<EmotionNotifier, EmotionResponse>(
  () => EmotionNotifier(),
);
