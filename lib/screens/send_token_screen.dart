import 'package:flutter/material.dart';

class SendTokenScreen extends StatefulWidget {
  const SendTokenScreen({super.key});

  @override
  _SendTokenScreenState createState() => _SendTokenScreenState();
}

class _SendTokenScreenState extends State<SendTokenScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Token'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Recipient Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Implement send token logic here
                String address = _addressController.text;
                String amount = _amountController.text;
                // TODO: Add functionality to send the token
                print('Sending $amount tokens to $address');
              },
              child: const Text('Send Token'),
            ),
          ],
        ),
      ),
    );
  }
}
