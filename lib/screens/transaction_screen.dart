import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Transactions'),
      ),
      child: Center(
        child: Text('Your Transaction History Here'),
      ),
    );
  }
}
