import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_wallet_connect/screens/wallet_history.dart';
import 'screens/home_screen.dart';
import 'screens/chain_selection_screen.dart';
import 'screens/settings_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet Connect',
      home: const HomeScreen(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.black),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blue,
      ),
      routes: {
        '/chainSelection': (context) => const ChainSelectionScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
