import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Wallet Connect',
      home: HomeScreen(),
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
    );
  }
}
