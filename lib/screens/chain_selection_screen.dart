import 'package:flutter/material.dart';

class ChainSelectionScreen extends StatelessWidget {
  const ChainSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Chain'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose a Blockchain Network',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildChainButton(context, 'Ethereum', Colors.blueAccent),
            const SizedBox(height: 10),
            _buildChainButton(context, 'Solana', Colors.green),
            const SizedBox(height: 10),
            _buildChainButton(context, 'Binance', Colors.yellow),
          ],
        ),
      ),
    );
  }

  Widget _buildChainButton(
      BuildContext context, String chainName, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        // Implement your chain selection action here
        // For example, navigate to a different screen or set the chain in app state
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$chainName selected!')),
        );
      },
      child: Text(
        chainName,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
