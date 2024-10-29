import 'package:flutter/material.dart';
import '../utils/api_data.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = ApiData.wallet; // Get the wallet data

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Display wallet information
            Text(
              'Wallet Address: ${wallet.address}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Balance: \$${wallet.balance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Display tokens
            const Text(
              'Tokens:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...wallet.tokens.map((token) {
              return ListTile(
                title: Text(token.name),
                subtitle: Text(
                  '${token.amount} (${token.symbol}) - \$${token.price.toStringAsFixed(2)}',
                ),
              );
            }).toList(),

            const SizedBox(height: 20),

            // Display transactions
            const Text(
              'Recent Transactions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...ApiData.transactions.map((transaction) {
              return ListTile(
                title: Text(
                  'Transaction ID: ${transaction.id}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${transaction.type} \$${transaction.amount.toStringAsFixed(2)} on ${transaction.date}',
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
