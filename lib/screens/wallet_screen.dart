import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Wallet'),
      ),
      child: Center(
        child: Text('Your Wallet Information Here'),
      ),
    );
  }
}
