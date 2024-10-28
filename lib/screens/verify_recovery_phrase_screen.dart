import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    _checkWalletCreationStatus();
    _selectRandomWords();
    _wordControllers.addAll(List.generate(4, (_) => TextEditingController()));
  }

  Future<void> _checkWalletCreationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isWalletCreated = prefs.getBool('walletCreated') ?? false;

    if (isWalletCreated) {
      // Redirect to main screen if wallet is already created
      Navigator.pushReplacementNamed(
          context, '/home'); // Adjust this route as needed
    }
  }

  void _selectRandomWords() {
    final random = Random();
    final words = widget.recoveryPhrase.split(' ');

    // Select 4 unique random indices from the words list
    selectedIndices = [];
    while (selectedIndices.length < 4) {
      int index = random.nextInt(words.length);
      if (!selectedIndices.contains(index)) {
        selectedIndices.add(index);
      }
    }

    selectedWords = selectedIndices.map((index) => words[index]).toList();
  }

  Future<void> _validateAndProceed() async {
    bool isPasswordValid =
        _passwordController.text == _confirmPasswordController.text;
    bool isPasswordStrong = _isPasswordStrong(_passwordController.text);
    bool areWordsValid = true;

    for (int i = 0; i < selectedWords.length; i++) {
      if (_wordControllers[i].text.trim() != selectedWords[i]) {
        areWordsValid = false;
        _isWordValid[i] = false;
      } else {
        _isWordValid[i] = true;
      }
    }

    String walletName = _walletNameController.text.trim();
    bool isWalletNameValid = walletName.isNotEmpty;

    if (isWalletNameValid &&
        isPasswordValid &&
        isPasswordStrong &&
        areWordsValid) {
      // Wallet creation successful
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('walletCreated', true);

      Navigator.pushReplacementNamed(
          context, '/chainSelection'); // Navigate to chain selection screen

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wallet created successfully!')),
      );
    } else {
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
      setState(() {});
    }
  }

  bool _isPasswordStrong(String password) {
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
            const Text('Wallet Name', style: TextStyle(fontSize: 16)),
            TextField(
              controller: _walletNameController,
              decoration: const InputDecoration(
                hintText: 'e.g. Trading, NFT Vault, Investment',
                hintStyle: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Create Password', style: TextStyle(fontSize: 16)),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'At least 8 characters in length',
                hintStyle: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Confirm Password', style: TextStyle(fontSize: 16)),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'At least 8 characters in length',
                hintStyle: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 30),
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
