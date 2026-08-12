import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentigo/models/emotion.dart';

class EmotionNotifier extends Notifier<EmotionResponse> {
  @override
  EmotionResponse build() {
    return EmotionResponse(
      message: '',
      success: false,
      emotion: '',
      confidence: 0,
      noEmotion: true,
    );
  }

  void setEmotion(EmotionResponse response) {
    state = response;
  }
}

final emotionProvider =
    NotifierProvider<EmotionNotifier, EmotionResponse>(
  () => EmotionNotifier(),
);