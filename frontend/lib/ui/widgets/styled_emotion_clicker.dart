import 'dart:developer';
import 'dart:convert';
import 'package:flutter_app/providers/emotion_providers.dart';
import 'package:flutter_app/providers/loading_provider.dart';
import 'package:flutter_app/providers/recommendation_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StyledEmotionClicker extends ConsumerStatefulWidget {
  const StyledEmotionClicker({super.key});

  @override
  ConsumerState<StyledEmotionClicker> createState() =>
      _StyledEmotionClickerState();
}

class _StyledEmotionClickerState extends ConsumerState<StyledEmotionClicker> {
  final String API_URL_EMOTION_SERVICE =
      dotenv.env['FLUTTER_APP_EMOTION_SERVICE'] ?? '';
  final String API_URL_RECOMMENDATION_SERVICE =
      dotenv.env['FLUTTER_APP_RECOMMENDATION_SERVICE'] ?? '';
  Future<Map<String, dynamic>> sendText(String text) async {
    ref.read(loadingProvider.notifier).setLoading(true);
    log('test', name: 'sendText');

    final url = Uri.parse(
      API_URL_EMOTION_SERVICE,
    ); //////////////////////////////////////////

    //log(_textController.text, name: "text");

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );

    log(response.statusCode.toString(), name: 'status code');
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log('Raw body: ${response.body}', name: 'response body');
      log('Data :  $data');
      ref.read(loadingProvider.notifier).setLoading(false);
      return data;
    } else {
      log('Error: ${response.statusCode}', name: 'error');
      ref.read(loadingProvider.notifier).setLoading(false);
      return {'emotion': 'Unknown', 'confidence': 0.0};
    }
  }

  Future<String> sendRecommendation(String emotion) async {
    ref.read(loadingProvider.notifier).setLoading(true);
    log('send recommendation', name: 'sendRecommendation');
    final url = Uri.parse(
      API_URL_RECOMMENDATION_SERVICE,
    ); //////////////////////////////////////////////

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

  final List<Map<String, dynamic>> emotions = [
    {'name': 'happy', 'label': '1'},
    {'name': 'disgust', 'label': '2'},
    {'name': 'fear', 'label': '3'},
    {'name': 'sad', 'label': '4'},
    {'name': 'angry', 'label': '5'},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      margin: EdgeInsets.only(bottom: 20, top: 20, left: 2, right: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: 120,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Or Click here...',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      log('Button pressed');
                      var newData = await sendText('I\'m feeling happy');
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
                      padding: EdgeInsets.symmetric(vertical: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      'Happy',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      log('Button pressed');
                    var newData = await sendText('I\'m feeling sad');
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
                      padding: EdgeInsets.symmetric(vertical: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      'Sad',
                      style: Theme.of(context).textTheme.bodyLarge,
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
