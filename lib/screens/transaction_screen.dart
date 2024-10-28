import 'package:flutter/cupertino.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Transactions'),
      ),
      child: Center(
        child: Text('Your Transaction History Here'),
      ),
    );
  }
}
