import 'package:flutter/material.dart';
import 'package:sentigo/ui/widgets/styled_appbar.dart';
import 'package:sentigo/ui/widgets/styled_emotion_output_box.dart';
import 'package:sentigo/ui/widgets/emotion_input_box.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(),

      body: Container(
        child: Column(
          children: [
            EmotionInputBox(),
            SizedBox(height : 20),
            StyledEmotionOutputBox(),
          ],
        ),
      ),
    );
  }
}
