import 'package:flutter/material.dart';
import 'dart:math';

class NewRecoveryPhraseScreen extends StatefulWidget {
  const NewRecoveryPhraseScreen({super.key});

  @override
  _NewRecoveryPhraseScreenState createState() =>
      _NewRecoveryPhraseScreenState();
}

class _NewRecoveryPhraseScreenState extends State<NewRecoveryPhraseScreen> {
  String recoveryPhrase = '';

  // Method to generate a new recovery phrase
  void _generateRecoveryPhrase() {
    // For simplicity, we're generating a random phrase from a list of words.
    // In a real application, you would implement a proper BIP39 or similar algorithm.
    const List<String> words = [
      'apple',
      'banana',
      'cherry',
      'date',
      'fig',
      'grape',
      'kiwi',
      'lemon',
      'mango',
      'nectarine',
      'orange',
      'papaya',
      'quince',
      'raspberry',
      'strawberry',
      'tangerine',
      'ugli',
      'vanilla',
      'watermelon',
    ];

    final random = Random();
    recoveryPhrase =
        List.generate(12, (_) => words[random.nextInt(words.length)]).join(' ');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _generateRecoveryPhrase(); // Generate the recovery phrase when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Recovery Phrase'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your new recovery phrase:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              recoveryPhrase,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please write this down and keep it safe.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement the functionality to save the recovery phrase securely
              },
              child: const Text('Save Recovery Phrase'),
            ),
          ],
        ),
      ),
    );
  }
}
