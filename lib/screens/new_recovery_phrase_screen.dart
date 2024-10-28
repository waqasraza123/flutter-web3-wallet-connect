import 'package:flutter/material.dart';
import '../models/wallet.dart';
import '../services/wallet_service.dart';
import 'verify_recovery_phrase_screen.dart'; // Import the new screen

class NewRecoveryPhraseScreen extends StatefulWidget {
  const NewRecoveryPhraseScreen({super.key});

  @override
  State<NewRecoveryPhraseScreen> createState() =>
      _NewRecoveryPhraseScreenState();
}

class _NewRecoveryPhraseScreenState extends State<NewRecoveryPhraseScreen> {
  final WalletService walletService = WalletService();
  late Wallet newWallet;
  bool isPhraseVisible = false;
  bool isWalletGenerated = false;

  @override
  void initState() {
    super.initState();
    _generateNewWallet();
  }

  void _generateNewWallet() {
    newWallet = walletService.createWallet();
    isWalletGenerated = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Recovery Phrase'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'DO NOT share your recovery phrase with ANYONE.\n'
              'Anyone with your recovery phrase can have full control over your assets. '
              'Please stay vigilant against phishing attacks at all times.\n\n'
              'Back up the phrase safely.\n'
              'You will never be able to restore your account without your recovery phrase.',
              style: TextStyle(fontSize: 14, color: Colors.redAccent),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  isPhraseVisible
                      ? newWallet.recoveryPhrase
                      : '******** ******** ******** ********',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPhraseVisible =
                        !isPhraseVisible; // Toggle phrase visibility
                  });
                },
                child:
                    Text(isPhraseVisible ? 'Hide My Phrase' : 'Show My Phrase'),
              ),
            ),
            const SizedBox(height: 30),

            if (isWalletGenerated) ...[
              const Text(
                'Wallet Address:',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8)),
                child: Text(newWallet.address,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 30),
            ],

            // Change button to "Next" if the phrase is visible
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (isPhraseVisible) {
                    // Navigate to the verification screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerifyRecoveryPhraseScreen(
                            recoveryPhrase: newWallet.recoveryPhrase),
                      ),
                    );
                  } else {
                    _generateNewWallet();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  isPhraseVisible ? 'Next' : 'Generate New Wallet',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
