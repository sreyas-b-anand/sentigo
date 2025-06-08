import 'package:flutter/material.dart';
import 'package:flutter_app/providers/loading_provider.dart';
import 'package:flutter_app/providers/emotion_providers.dart';
import 'package:flutter_app/providers/recommendation_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    final localEmotion = ref.watch(emotionProvider);
    final emotion = localEmotion['emotion'] ?? '';
    final confidence = localEmotion['confidence'] ?? 0;
    final recommendation = ref.watch(recommendationNotifier);
    final loading = ref.watch(loadingProvider);

    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                              color: const Color.fromARGB(255, 61, 61, 61),
                              size: 50.0,
                            ),
                          )
                        : (emotion != ''
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'We’ve analyzed your input and it seems you’re feeling:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      emotion,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Confidence Score: $confidence%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.grey[700],
                                            fontStyle: FontStyle.italic,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Text(
                                  'We couldn\'t detect any emotion yet!',
                                  style:
                                      Theme.of(context).textTheme.titleSmall,
                                  textAlign: TextAlign.center,
                                ),
                              )),

                    // Recommendations Tab
                    loading
                        ? Center(
                            child: SpinKitFadingCircle(
                              color: Theme.of(context).colorScheme.primary,
                              size: 50.0,
                            ),
                          )
                        : (recommendation != ''
                            ? Padding(
                                padding: const EdgeInsets.all(16),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '📝 Personalized Suggestions',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        recommendation,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              height: 1.5,
                                              color: Colors.black87,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Text(
                                    '🕒 Hold on...\nWe’re preparing personalized tips for you based on your emotional state.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: Colors.grey[700],
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
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
