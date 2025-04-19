import 'package:flutter/material.dart';
import 'package:flutter_app/styled_widgets/styled_appbar.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    home: Scaffold(
      appBar: StyledAppBar(),
      body: Center(
        child: Text('Hello, world!'),
      ),
    ),
  ));
}

