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
    // Loading
    if (loading) {
      return Center(
        child: SpinKitFadingCircle(
          color: Theme.of(context).colorScheme.primary,
          size: 50,
        ),
      );
    }
    if (!recommendation.success && recommendation.message.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Your personalized recommendations will appear here\n'
            'after we understand how you\'re feeling.',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: const Color.fromARGB(221, 82, 81, 81),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (!recommendation.success) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            recommendation.message.isNotEmpty
                ? recommendation.message
                : 'Something went wrong!',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (recommendation.recommendations.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'No recommendation is available yet.',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: Colors.grey[700]),
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
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Text(
            recommendation.recommendations,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(height: 1.5, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
