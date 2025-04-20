import 'dart:developer';

import 'package:flutter/material.dart';

class StyledEmotionInput extends StatefulWidget {
  const StyledEmotionInput({super.key});

  @override
  State<StyledEmotionInput> createState() => _StyledEmotionInputState();
}

class _StyledEmotionInputState extends State<StyledEmotionInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
      width: double.infinity,
      height: 320,
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            Image.asset('assets/images/icon.png').image,
                        radius: 15,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Sentigo here!!!',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hey there! ',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                      TextSpan(
                        text: 'How do you feel about your',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: ' current emotion?',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  minLines: 1,

                  decoration: InputDecoration(
                    hintText: 'Type here...',
                    hintStyle: TextStyle(
                      color: const Color.fromARGB(255, 122, 124, 122),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 240, 240, 240),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),
              ElevatedButton(
                onPressed: () {
                  log('Button Pressed', name: 'buttonPressed');
                },
                style: ButtonStyle(
                  alignment: Alignment.center,
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                child: Transform.rotate(
                  angle: -45 * 3.14 / 180,
                  child: Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}






// Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//               color: const Color.fromARGB(255, 244, 243, 243),
//             ),

//             child: Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: Image.asset('assets/images/icon.png').image,
//                   radius: 22,
//                 ),
//                 SizedBox(width: 20),
//                 Text(title, style: Theme.of(context).textTheme.bodyLarge),
//               ],
//             ),
//           ),