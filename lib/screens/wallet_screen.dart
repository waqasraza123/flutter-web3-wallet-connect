import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import Cupertino icons
import '../utils/api_data.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = ApiData.wallet;

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wallets'),
        ),
        body: SingleChildScrollView(
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
                      style: TextStyle(fontSize: 16, color: Colors.grey),
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
                        context, 'Send', CupertinoIcons.arrow_up),
                    _buildActionButton(
                        context, 'Receive', CupertinoIcons.arrow_down),
                    _buildActionButton(
                        context, 'Buy', CupertinoIcons.purchased_circle),
                    _buildActionButton(
                        context, 'Trade', CupertinoIcons.arrow_swap),
                  ],
                ),
              ),

              // Tabs for Coins and NFTs below action buttons
              const TabBar(
                tabs: [
                  Tab(text: 'Coins'),
                  Tab(text: 'NFTs'),
                ],
              ),

              // Content area for Coins and NFTs
              SizedBox(
                height: 300, // Adjust height to fit content
                child: TabBarView(
                  children: [
                    // Coins tab content
                    _buildCoinsTab(),

                    // NFTs tab placeholder content
                    const Center(
                      child: Text(
                        'NFTs content will be displayed here',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.briefcase), // Changed to Cupertino icon
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), // Changed to Cupertino icon
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings), // Changed to Cupertino icon
              label: 'Settings',
            ),
          ],
          currentIndex: 0, // Set the current index of the bottom navigation
          onTap: (index) {
            // Handle bottom navigation tap
          },
        ),
      ),
    );
  }

  // Helper method to build action buttons
  ElevatedButton _buildActionButton(
      BuildContext context, String title, IconData icon) {
    return ElevatedButton(
      onPressed: () {
        // Handle button action
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
        shape: const CircleBorder(), // Sets the button shape to circular
        padding: const EdgeInsets.all(20), // Padding to increase button size
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32), // Keeping the same size for consistency
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 10, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // Widget to build the Coins tab with the top 5 crypto tokens
  Widget _buildCoinsTab() {
    final topTokens = ApiData.topTokens; // Fetch top 5 tokens from ApiData

    return ListView.builder(
      itemCount: topTokens.length,
      itemBuilder: (context, index) {
        final token = topTokens[index];
        return ListTile(
          leading: const Icon(CupertinoIcons.bitcoin),
          title: Text(token['name']),
          subtitle: Text('Price: \$${token['price'].toStringAsFixed(2)}'),
          trailing: Text(
            '${token['change']}%',
            style: TextStyle(
              color: token['change'] >= 0 ? Colors.green : Colors.red,
            ),
          ),
        );
      },
    );
  }
}
