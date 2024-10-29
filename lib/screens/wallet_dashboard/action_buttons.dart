import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(context, 'Send', CupertinoIcons.arrow_up),
          _buildActionButton(context, 'Receive', CupertinoIcons.arrow_down),
          _buildActionButton(context, 'Buy', CupertinoIcons.purchased_circle),
          _buildActionButton(context, 'Trade', CupertinoIcons.arrow_swap),
        ],
      ),
    );
  }

  ElevatedButton _buildActionButton(
      BuildContext context, String title, IconData icon) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text('You tapped $title.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        backgroundColor: Colors.white, // Set background color to white
        foregroundColor: Colors.black, // Set icon and text color to black
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 10, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
