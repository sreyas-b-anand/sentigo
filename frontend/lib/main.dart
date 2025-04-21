import 'package:flutter/material.dart';
import 'package:flutter_app/ui/screens/home.dart';
import 'package:flutter_app/ui/screens/loading.dart';
import 'package:flutter_app/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: appTheme,
        initialRoute: '/loading',
        routes: {
          '/loading': (context) => const Loading(),
          '/home': (context) => const Home(),
        },
      ),
    ),
  );
}
