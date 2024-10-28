import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  final String walletName;

  WalletCard({required this.walletName});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            walletName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // Add more wallet details as needed
        ],
      ),
    );
  }
}
