import 'dart:convert';
import 'dart:developer';
import 'package:flutter_app/providers/emotion_providers.dart';
import 'package:flutter_app/providers/loading_provider.dart';
import 'package:flutter_app/providers/recommendation_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class StyledEmotionInputBox extends ConsumerStatefulWidget {
  const StyledEmotionInputBox({super.key});

  @override
  ConsumerState<StyledEmotionInputBox> createState() =>
      _StyledEmotionInputBoxState();
}

class _StyledEmotionInputBoxState extends ConsumerState<StyledEmotionInputBox> {
  final TextEditingController _textController = TextEditingController();

  Future<Map<String, dynamic>> sendText() async {
    ref.read(loadingProvider.notifier).setLoading(true);
    log('send text', name: 'sendText');

    final url = Uri.parse('http://10.0.2.2:5000/get_emotion');

    log(_textController.text, name: "text");

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': _textController.text}),
    );

    log(response.statusCode.toString(), name: 'status code');
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log('Raw body: ${response.body}', name: 'response body');
      log('Data :  $data');
      ref.read(loadingProvider.notifier).setLoading(false);
      _textController.text = '';
      return data;
    } else {
      log('Error: ${response.statusCode}', name: 'error');
      ref.read(loadingProvider.notifier).setLoading(false);
      _textController.text = '';

      return {'emotion': 'Unknown', 'confidence': 0.0};
    }
  }

  Future<String> sendRecommendation(emotion) async {
    ref.read(loadingProvider.notifier).setLoading(true);
    log('send recommendation', name: 'sendRecommendation');
    final url = Uri.parse('http://10.0.2.2:5001/get_recommendation');

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'emotion': emotion}),
    );
    if (response.statusCode == 200) {
      log('Raw body: ${response.body}', name: 'response body');
      var data = jsonDecode(response.body);
      ref.read(loadingProvider.notifier).setLoading(false);
      return data['recommendations'];
    } else {
      log('Error: ${response.statusCode}', name: 'error');
      ref.read(loadingProvider.notifier).setLoading(false);
      return 'No recommendation available';
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
      ),
      width: double.infinity,
      height: 320,
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
                        text: 'How do you feel about your',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 28,
                        ),
                      ),
                      TextSpan(
                        text: ' current emotion?',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
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
                  onPressed: () async {
                    log('Button pressed');
                    var newData = await sendText();
                    log('New data received: $newData');

                    ref
                        .read(emotionProvider.notifier)
                        .setEmotion(
                          newData['emotion'],
                          newData['confidence'].toString(),
                        );

                    var value = await sendRecommendation(newData['emotion']);

                    ref
                        .read(recommendationNotifier.notifier)
                        .setRecommendation(value);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    elevation: 2,
                  ),
                  child: Transform.rotate(
                    angle: -45 * 3.14 / 180,
                    child: const Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
