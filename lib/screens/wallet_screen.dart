import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../utils/api_data.dart';
import 'wallet_dashboard/balance_header_widget.dart';
import './wallet_dashboard/action_buttons.dart';
import './wallet_dashboard/wallet_tabs.dart';
import './wallet_dashboard/bottom_navigation.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.inkDrop(
              color: Colors.white,
              size: 50,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final wallet = snapshot.data;

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(title: const Text('Wallets')),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  WalletBalanceHeaderWidget(
                      walletAddress: dotenv.env['ETH_WALLET_ADDRESS']!),
                  const ActionButtons(),
                  const WalletTabs(),
                ],
              ),
            ),
            bottomNavigationBar: const BottomNav(),
          ),
        );
      },
    );
  }

  Future<dynamic> _fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return ApiData.wallet;
  }
}
