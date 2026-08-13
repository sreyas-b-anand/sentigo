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
          color: Color.fromARGB(255, 61, 61, 61),
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
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDEEE3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.favorite_outline,
                    size: 20,
                    color: Color(0xFF8A6652),
                  ),
                ),

                const SizedBox(width: 10),

                Text(
                  'A little something for you',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  recommendation.recommendations,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    color: const Color(0xFF4F4945),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
