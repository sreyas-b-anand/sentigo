import 'package:flutter/material.dart';

class StyledEmotionClicker extends StatefulWidget {
  const StyledEmotionClicker({super.key});

  @override
  State<StyledEmotionClicker> createState() => _StyledEmotionClickerState();
}

class _StyledEmotionClickerState extends State<StyledEmotionClicker> {
  final List<Map<String, dynamic>> emotions = [
    {'name': 'Happy', 'icon': Icons.sentiment_very_satisfied},
    {'name': 'Sad', 'icon': Icons.sentiment_dissatisfied},
    {'name': 'Angry', 'icon': Icons.sentiment_very_dissatisfied},
    {'name': 'Surprised', 'icon': Icons.sentiment_neutral},
    {'name': 'Confused', 'icon': Icons.sentiment_satisfied},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      margin: EdgeInsets.only(bottom: 20, top: 20, left: 2, right: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      height: 120,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Or Click here...',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: emotions.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,

              itemBuilder:
                  (context, index) => GestureDetector(
                    onTap: () {
                      // Handle the click event here
                      print('Clicked on ${emotions[index]['name']}');
                    },

                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: CircleAvatar(
                        child: Icon(emotions[index]['icon'], size: 48),
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
