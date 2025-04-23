import 'package:flutter_riverpod/flutter_riverpod.dart';
class EmotionNotifier extends Notifier<Map<String, String>> {
  @override
  Map<String, String> build() {
    return {
      'emotion': '',
      'confidence': '',
    };
  }

  void setEmotion(String emotion, String confidence) {
    state = {
      'emotion': emotion,
      'confidence': confidence,
    };
  }
}

final emotionProvider = NotifierProvider<EmotionNotifier, Map<String, String>>(() {
  return EmotionNotifier();
});
