import 'package:flutter/material.dart';
import 'package:sentigo/ui/screens/home.dart';
import 'package:sentigo/ui/screens/loading.dart';
import 'package:sentigo/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

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
