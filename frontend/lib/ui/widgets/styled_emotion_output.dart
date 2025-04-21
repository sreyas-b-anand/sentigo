import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StyledEmotionClicker extends ConsumerStatefulWidget {
  const StyledEmotionClicker({super.key});

  @override
  ConsumerState<StyledEmotionClicker> createState() => _StyledEmotionClickerState();
}

class _StyledEmotionClickerState extends ConsumerState<StyledEmotionClicker> {
  final List<Map<String, dynamic>> emotions = [
    {'name': '1'},
    {'name': '2'},
    {'name': '3'},
    {'name': '4'},
    {'name': '5'},
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
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: Row(
              children:
                  emotions.map((emotion) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Handle the click event here
                          print('Clicked on ${emotion['name']}!');
                        },
                        child: CircleAvatar(
                          radius: 20,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                emotion['name'],
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
