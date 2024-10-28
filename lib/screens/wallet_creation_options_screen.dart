import 'package:flutter/material.dart';
import 'new_recovery_phrase_screen.dart';

class WalletCreationOptionsScreen extends StatelessWidget {
  const WalletCreationOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Wallet Creation Method'),
      ),
      backgroundColor: const Color.fromRGBO(
          9, 9, 10, 1), // Set background color for the whole screen
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Select the way you want to create your wallet',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white), // Set text color to white for visibility
                ),
                const SizedBox(height: 20),

                // Box for "Use Recovery Phrase"
                _buildCard(context,
                    title: 'Use Recovery Phrase',
                    description:
                        'Maximum control & high compatibility across all wallets',
                    buttonText: 'Create new recovery phrase', onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewRecoveryPhraseScreen()),
                  );
                },
                    textButtonText: 'Import existing recovery phrase',
                    bottomText: 'Higher Security'),
                const SizedBox(height: 20), // Spacing between cards

                // Box for "Sign-up with Google"
                _buildCard(context,
                    title: 'Sign-up with Google',
                    description:
                        'Simple & easy registration options with Google',
                    buttonText: 'Connect with Google', onPressed: () {
                  // Implement Google sign-up functionality
                }, textButtonText: null, bottomText: 'More Convenience'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title,
      required String description,
      required String buttonText,
      required VoidCallback onPressed,
      String? textButtonText,
      String bottomText = ''}) {
    return Container(
      height: 250, // Set a fixed height for uniformity
      width: double.infinity, // Make the card take full width
      child: Card(
        color: const Color.fromRGBO(
            29, 29, 31, 1), // Set the card's background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // Set title text color to white
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const Spacer(), // Adds flexible space to push content down
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              if (textButtonText != null) ...[
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Implement existing recovery phrase import
                  },
                  child: Text(
                    textButtonText,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              const Spacer(), // Adds space below the button and text button
              Align(
                alignment:
                    Alignment.bottomLeft, // Align bottomText to the bottom left
                child: Text(
                  bottomText,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
