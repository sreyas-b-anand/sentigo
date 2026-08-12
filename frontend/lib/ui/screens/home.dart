import 'package:flutter/material.dart';
import 'package:sentigo/ui/widgets/appbar.dart';
import 'package:sentigo/ui/widgets/output_box.dart';
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
            EmotionOutputBox(),
          ],
        ),
      ),
    );
  }
}
