import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class NewRecoveryPhraseScreen extends StatelessWidget {
  const NewRecoveryPhraseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletService walletService = WalletService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Recovery Phrase'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Create a new wallet
                Wallet newWallet = walletService.createWallet();

                // Save the wallet securely
                await walletService.saveWallet(newWallet);

                // Show the recovery phrase to the user
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Your Recovery Phrase'),
                    content: Text(newWallet.recoveryPhrase),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          Navigator.of(context).pop(); // Navigate back
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Generate New Wallet'),
            ),
          ],
        ),
      ),
    );
  }
}
