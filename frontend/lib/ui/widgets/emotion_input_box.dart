import 'package:sentigo/providers/emotion_providers.dart';
import 'package:sentigo/providers/loading_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:sentigo/providers/recommendation_provider.dart';

import 'package:sentigo/services/emotion_services.dart';
import 'package:sentigo/services/recommendation_services.dart';

class EmotionInputBox extends ConsumerStatefulWidget {
  const EmotionInputBox({super.key});

  @override
  ConsumerState<EmotionInputBox> createState() => _StyledEmotionInputBoxState();
}

class _StyledEmotionInputBoxState extends ConsumerState<EmotionInputBox> {
  final TextEditingController _textController = TextEditingController();
  Future<void> _handleEmotion() async {
    final emotionService = EmotionServices();
    final recommendationService = RecommendationServices();

    final text = _textController.text.trim();

    if (text.isEmpty) {
      return;
    }
    ref.read(loadingProvider.notifier).setLoading(true);

    try {
      final emotionResponse = await emotionService.getEmotion(text);

      ref.read(emotionProvider.notifier).setEmotion(emotionResponse);

      if (emotionResponse.success && !emotionResponse.noEmotion) {
        final recommendationResponse = await recommendationService
            .getRecommendation(emotionResponse.emotion);

        ref
            .read(recommendationProvider.notifier)
            .setRecommendation(recommendationResponse);
      }

      _textController.clear();
    } catch (e) {
      print('Error: $e');
    } finally {
      ref.read(loadingProvider.notifier).setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      width: double.infinity,
      
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            Image.asset('assets/images/icon.png').image,
                        radius: 12,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Sentigo here!!!',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hey! ',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 28,
                        ),
                      ),

                      TextSpan(
                        text: 'Anything to share here?',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    minLines: 1,
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type your emotion...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 18,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF4F4F4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _handleEmotion,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    elevation: 2,
                  ),
                  child: const Icon(Icons.check, color: Colors.black, size: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
