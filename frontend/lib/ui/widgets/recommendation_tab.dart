import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sentigo/models/recommendation.dart';

class RecommendationTab extends StatelessWidget {
  final RecommendationResponse recommendation;
  final bool loading;

  const RecommendationTab({
    super.key,
    required this.recommendation,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: SpinKitFadingCircle(
          color: Theme.of(context).colorScheme.primary,
          size: 50,
        ),
      );
    }

    if (!recommendation.success ||
        recommendation.recommendations.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            '🕒 Hold on...\n'
            'We’re preparing personalized tips for you based on your emotional state.',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          recommendation.recommendations,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.5,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}