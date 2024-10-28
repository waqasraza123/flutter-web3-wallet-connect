import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'wallet_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      child: Center(
        child: CupertinoButton(
          child: Text('Go to Wallet'),
          onPressed: () {
            // Navigate to Wallet Screen
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => WalletScreen()),
            );
          },
        ),
      ),
    );
  }
}
