import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../services/moralis/wallet_net_worth_service.dart';

class WalletBalanceHeaderWidget extends StatelessWidget {
  final String walletAddress;

  const WalletBalanceHeaderWidget({super.key, required this.walletAddress});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: WalletNetWorthService.fetchWalletNetWorth(walletAddress),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: LoadingAnimationWidget.newtonCradle(
              color: Colors.black,
              size: 50,
            ),
          );
        } else if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Failed to load balance',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          final balance = snapshot.data?['total_networth_usd'] ?? '0.00';
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$$balance',
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Current Balance',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
