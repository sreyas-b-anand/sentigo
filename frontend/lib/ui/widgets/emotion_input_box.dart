import 'package:sentigo/providers/emotion_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

class EmotionInputBox extends ConsumerStatefulWidget {
  const EmotionInputBox({super.key});

  @override
  ConsumerState<EmotionInputBox> createState() => _StyledEmotionInputBoxState();
}

class _StyledEmotionInputBoxState extends ConsumerState<EmotionInputBox> {
  final TextEditingController _textController = TextEditingController();
  Future<void> _handleEmotion() async {
  final text = _textController.text.trim();

  if (text.isEmpty) return;

  await ref.read(emotionProvider.notifier).analyze(text);

  _textController.clear();
}
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: Image.asset('assets/images/icon.png').image,
                radius: 12,
              ),
              const SizedBox(width: 10),
              Text(
                'Sentigo here!!!',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Hey! ',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w200,
                    fontSize: 28,
                  ),
                ),
                TextSpan(
                  text: 'Anything to share here?',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w200,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

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
                    controller: _textController,
                    minLines: 1,
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
