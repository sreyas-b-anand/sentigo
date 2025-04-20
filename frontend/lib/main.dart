
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/screens/loading.dart';
import 'package:flutter_app/ui/widgets/styled_appbar.dart';
import 'package:flutter_app/theme/theme.dart';

void main() {
  runApp(MaterialApp(
    theme:  appTheme,
    initialRoute: '/loading',
    routes: {
      '/loading':(context) => const Loading(),
      '/home':(context)=> Scaffold(appBar: StyledAppBar(), body: Text("data"),),
    },
  ));
}

