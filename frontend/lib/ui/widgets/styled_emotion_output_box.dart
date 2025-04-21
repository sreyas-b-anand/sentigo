import 'package:flutter/material.dart';
import 'package:flutter_app/providers/emotion_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StyledEmotionOutputBox extends ConsumerStatefulWidget {
  const StyledEmotionOutputBox({super.key});

  @override
  ConsumerState<StyledEmotionOutputBox> createState() =>
      _StyledEmotionOutputBoxState();
}

class _StyledEmotionOutputBoxState
    extends ConsumerState<StyledEmotionOutputBox> {
  @override
  Widget build(BuildContext context) {
    String localEmotion = ref.watch(emotionProvider);
    return Container(padding: EdgeInsets.all(30), child: Text(localEmotion));
  }
}
