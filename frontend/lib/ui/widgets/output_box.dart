import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sentigo/providers/emotion_providers.dart';
import 'package:sentigo/providers/loading_provider.dart';
import 'package:sentigo/providers/recommendation_provider.dart';

import 'package:sentigo/ui/widgets/emotion_tab.dart';
import 'package:sentigo/ui/widgets/recommendation_tab.dart';

class EmotionOutputBox extends ConsumerWidget {
  const EmotionOutputBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emotion = ref.watch(emotionProvider);
    final recommendation = ref.watch(recommendationProvider);
    final loading = ref.watch(loadingProvider);

    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Container(
          padding: const EdgeInsets.all(20),
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
              Center(
                child: Text(
                  'Sentigo predicts that...',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Color.fromARGB(255, 45, 43, 43),
                indicatorColor: Colors.black,
                tabs: [Tab(text: 'Your Emotion'), Tab(text: 'Do This Now')],
              ),

              const SizedBox(height: 6),

              Expanded(
                child: TabBarView(
                  children: [
                    EmotionTab(emotion: emotion, loading: loading),
                    RecommendationTab(
                      recommendation: recommendation,
                      loading: loading,
                    ),
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
