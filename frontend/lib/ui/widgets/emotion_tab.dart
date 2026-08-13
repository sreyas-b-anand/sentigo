import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sentigo/models/emotion.dart';

class EmotionTab extends StatelessWidget {
  final EmotionResponse emotion;
  final bool loading;

  const EmotionTab({super.key, required this.emotion, required this.loading});

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: SpinKitFadingCircle(
          color: Color.fromARGB(255, 61, 61, 61),
          size: 50,
        ),
      );
    }

    if (!emotion.success && emotion.message.isEmpty) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            'Share how you\'re feeling to get started',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: const Color.fromARGB(221, 82, 81, 81),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (!emotion.success) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            emotion.message.isNotEmpty
                ? emotion.message
                : 'Something went wrong!',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: const Color.fromARGB(221, 255, 2, 2)),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (emotion.noEmotion) {
      return Center(
        child: Text(
          'We couldn\'t detect any emotion yet!',
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'We\'ve analyzed your input and it seems you\'re feeling:',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: const Color.fromARGB(221, 53, 53, 53),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          Text(
            emotion.emotion,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            'Confidence Score: ${emotion.confidence}%',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[700],
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
