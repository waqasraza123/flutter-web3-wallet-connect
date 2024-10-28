import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final String transactionDetails;

  TransactionItem({required this.transactionDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        transactionDetails,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
