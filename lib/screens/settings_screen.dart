import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Professional description text
            const Text(
              'Import Your Existing Wallet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'To seamlessly integrate your digital assets, please enter the address associated with your existing wallet (e.g., from OKX, MetaMask, or Phantom). Once imported, your token and NFT data will sync automatically within the app.',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            // Wallet Address input field
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Wallet Address',
                hintText: '0x00000000219ab540356cBB839Cbe05303d7705Fa',
                hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Import wallet button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  final address = addressController.text;
                  // Add functionality here to import wallet with address
                },
                child: const Text(
                  'Import Wallet with Address',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
