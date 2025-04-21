import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/styled_appbar.dart';
import 'package:flutter_app/ui/widgets/styled_emotion_output.dart';
import 'package:flutter_app/ui/widgets/styled_emotion_output_box.dart';
import 'package:flutter_app/ui/widgets/styled_input_box.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(),

      body: Container(
        child: Column(
          children: [
            StyledEmotionInputBox(),
            StyledEmotionClicker(),
            StyledEmotionOutputBox(),
          ],
        ),
      ),
    );
  }
}
