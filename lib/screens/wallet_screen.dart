import 'package:flutter/cupertino.dart';
import '../utils/api_data.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = ApiData.wallet;

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.briefcase),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 0, // Set the current index of the bottom navigation
        onTap: (index) {
          // Handle bottom navigation tap
        },
      ),
      tabBuilder: (context, index) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Wallets'),
          ),
          child: Column(
            children: [
              // Header with current balance
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${wallet.balance.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Current Balance',
                      style: TextStyle(
                          fontSize: 16, color: CupertinoColors.secondaryLabel),
                    ),
                  ],
                ),
              ),

              // Action buttons
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(
                        context, 'Send', CupertinoIcons.arrow_up_right_circle),
                    _buildActionButton(context, 'Receive',
                        CupertinoIcons.arrow_down_left_circle),
                    _buildActionButton(
                        context, 'Buy', CupertinoIcons.plus_rectangle),
                    _buildActionButton(context, 'Trade',
                        CupertinoIcons.arrow_right_circle_fill),
                  ],
                ),
              ),

              // Tabs for Coins and NFTs
              CupertinoSegmentedControl<int>(
                children: const {
                  0: Text('Coins'),
                  1: Text('NFTs'),
                },
                onValueChanged: (int value) {
                  // Handle tab change if needed
                },
                groupValue: 0, // Set default selected tab
              ),

              // Spacer for content area
              const SizedBox(height: 16),

              // Placeholder for content based on selected tab
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Coins and NFTs content will be displayed here',
                    style: TextStyle(
                        fontSize: 18, color: CupertinoColors.secondaryLabel),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper method to build action buttons
  CupertinoButton _buildActionButton(
      BuildContext context, String title, IconData icon) {
    return CupertinoButton(
      onPressed: () {
        // Handle button action
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text('You tapped $title.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 4),
          Text(title),
        ],
      ),
    );
  }
}
