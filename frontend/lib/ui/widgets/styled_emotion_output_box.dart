import 'package:flutter/material.dart';
import 'package:flutter_app/providers/loading_provider.dart';
import 'package:flutter_app/providers/emotion_providers.dart';
import 'package:flutter_app/providers/recommendation_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import the spin kit package

class StyledEmotionOutputBox extends ConsumerStatefulWidget {
  const StyledEmotionOutputBox({super.key});

  @override
  ConsumerState<StyledEmotionOutputBox> createState() =>
      _StyledEmotionOutputBoxState();
}

class _StyledEmotionOutputBoxState extends ConsumerState<StyledEmotionOutputBox>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final localEmotion = ref.watch(
      emotionProvider,
    ); // { emotion: 'Happy', confidence: 0.9 }
    final emotion = localEmotion['emotion'] ?? '';
    final confidence = localEmotion['confidence'] ?? 0; // Convert to percentage

    final recommendation = ref.watch(recommendationNotifier);

    // Watch the loading state
    final loading = ref.watch(loadingProvider);

    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sentigo predicts that...',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: const Color.fromARGB(255, 45, 43, 43),
                indicatorColor: Colors.black,
                tabs: const [
                  Tab(text: '🧠 Your Emotion'),
                  Tab(text: '💡 Do This Now'),
                ],
              ),
              const SizedBox(height: 6),
              Expanded(
                child: TabBarView(
                  children: [
                    // Emotion Tab
                    loading
                        ? Center(
                          child: SpinKitFadingCircle(
                            color: Theme.of(context).colorScheme.primary,
                            size: 50.0,
                          ),
                        ) // Custom spinner animation
                        : (localEmotion['emotion'] != ''
                            ? Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'You are feeling',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 2),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: emotion,
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.titleLarge,
                                        ),
                                        TextSpan(
                                          text:
                                              '\n with a confidence score of ',
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyLarge,
                                        ),
                                        TextSpan(
                                          text: "$confidence%",
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : Center(
                              child: Text(
                                'We couldn\'t detect an emotion yet!',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            )),

                    // Recommendations Tab
                    loading
                        ? Center(
                          child: SpinKitFadingCircle(
                            color: Theme.of(context).colorScheme.primary,
                            size: 50.0,
                          ),
                        ) // Custom spinner animation
                        : (recommendation != ''
                            ? Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Here are some suggestions for you',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),

                                  const SizedBox(height: 4),
                                  Text(
                                    recommendation,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            )
                            : Center(
                              child: Text(
                                'Hang tight! We\'ll have suggestions once we detect how you feel.',
                                style: Theme.of(context).textTheme.titleSmall,
                                textAlign: TextAlign.center,
                              ),
                            )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
