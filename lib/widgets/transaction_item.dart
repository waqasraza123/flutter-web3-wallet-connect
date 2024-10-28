import 'package:flutter/cupertino.dart';

class TransactionItem extends StatelessWidget {
  final String transactionDetails;

  const TransactionItem({super.key, required this.transactionDetails});

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
      child: Text(
        transactionDetails,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
