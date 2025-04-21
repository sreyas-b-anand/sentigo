import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmotionNotifier extends Notifier<String> {
  @override
  String state = "Type something to get the emotion";

  @override
  String build() {
    return state;
  }

  void setEmotion(String emotion) {
    state = emotion;
  }
}

final emotionProvider = NotifierProvider<EmotionNotifier, String>(() {
  return EmotionNotifier();
});
