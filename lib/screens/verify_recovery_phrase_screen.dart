import 'package:flutter/material.dart';
import 'dart:math';

class VerifyRecoveryPhraseScreen extends StatefulWidget {
  final String recoveryPhrase;

  const VerifyRecoveryPhraseScreen({super.key, required this.recoveryPhrase});

  @override
  State<VerifyRecoveryPhraseScreen> createState() =>
      _VerifyRecoveryPhraseScreenState();
}

class _VerifyRecoveryPhraseScreenState
    extends State<VerifyRecoveryPhraseScreen> {
  late List<String> selectedWords;
  late List<int> selectedIndices; // To hold the random indices
  final TextEditingController _walletNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final List<TextEditingController> _wordControllers = [];
  final List<bool> _isWordValid = [true, true, true, true];

  @override
  void initState() {
    super.initState();
    _selectRandomWords();
    _wordControllers.addAll(List.generate(4, (_) => TextEditingController()));
  }

  void _selectRandomWords() {
    final random = Random();
    final words = widget.recoveryPhrase
        .split(' '); // Split the recovery phrase into words

    // Select 4 unique random indices from the words list
    selectedIndices = [];
    while (selectedIndices.length < 4) {
      int index = random.nextInt(words.length);
      if (!selectedIndices.contains(index)) {
        selectedIndices.add(index);
      }
    }

    // Get the words at the selected indices
    selectedWords = selectedIndices.map((index) => words[index]).toList();
  }

  void _validateAndProceed() {
    bool isPasswordValid =
        _passwordController.text == _confirmPasswordController.text;
    bool isPasswordStrong = _isPasswordStrong(_passwordController.text);
    bool areWordsValid = true;

    // Validate entered words against the original recovery phrase
    for (int i = 0; i < selectedWords.length; i++) {
      if (_wordControllers[i].text.trim() != selectedWords[i]) {
        areWordsValid = false;
        _isWordValid[i] = false; // Mark invalid
      } else {
        _isWordValid[i] = true; // Mark valid
      }
    }

    // Validate wallet name
    String walletName = _walletNameController.text.trim();
    bool isWalletNameValid = walletName.isNotEmpty;

    if (isWalletNameValid &&
        isPasswordValid &&
        isPasswordStrong &&
        areWordsValid) {
      // Proceed to animation screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AnimationScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AnimationScreen()),
      );
      // Show errors
      if (!isPasswordValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
      }
      if (!isPasswordStrong) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Password must be at least 8 characters long and contain letters and numbers')),
        );
      }
      if (!isWalletNameValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wallet name cannot be empty')),
        );
      }
      setState(() {}); // Trigger rebuild to show errors
    }
  }

  bool _isPasswordStrong(String password) {
    // Check for at least 8 characters, at least one letter and one number
    return password.length >= 8 &&
        password.contains(RegExp(r'[a-zA-Z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Your Recovery Phrase'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fill out the words according to their positions to verify that you have stored your phrase safely.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Display the positions to verify
            for (int i = 0; i < selectedWords.length; i++) ...[
              Text('Word at position ${selectedIndices[i] + 1}:',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextField(
                controller: _wordControllers[i],
                decoration: InputDecoration(
                  hintText: 'Enter word ${i + 1}',
                  hintStyle: const TextStyle(fontSize: 12),
                  errorText: _isWordValid[i] ? null : 'Incorrect word',
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isWordValid[i] ? Colors.grey : Colors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],

            const SizedBox(height: 20),
            const Text(
              'Wallet Name',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _walletNameController,
              decoration: const InputDecoration(
                hintText: 'e.g. Trading, NFT Vault, Investment',
                hintStyle: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Create Password',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'At least 8 characters in length',
                hintStyle: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Confirm Password',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'At least 8 characters in length',
                hintStyle: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 30),

            // Next button to proceed
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _validateAndProceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimationScreen extends StatelessWidget {
  const AnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Replace with your animation
            SizedBox(height: 20),
            Text('Creating your wallet...', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

class SelectChainScreen extends StatelessWidget {
  const SelectChainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Blockchain'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Please select a blockchain:',
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Ethereum'),
              onTap: () {
                // Handle Ethereum selection
              },
            ),
            ListTile(
              title: const Text('Solana'),
              onTap: () {
                // Handle Solana selection
              },
            ),
            ListTile(
              title: const Text('Binance'),
              onTap: () {
                // Handle Binance selection
              },
            ),
            // Add more chains as needed
          ],
        ),
      ),
    );
  }
}
