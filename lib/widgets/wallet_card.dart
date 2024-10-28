import 'package:flutter/cupertino.dart';

class WalletCard extends StatelessWidget {
  final String walletName;

  const WalletCard({super.key, required this.walletName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            walletName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // Add more wallet details as needed
        ],
      ),
    );
  }
}
