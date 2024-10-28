import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/chain_selection_screen.dart'; // Import your ChainSelectionScreen

void main() {
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
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blue,
      ),
      routes: {
        // Define the chainSelection route here
        '/chainSelection': (context) => const ChainSelectionScreen(),
      },
    );
  }
}
