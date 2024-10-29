import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/api_data.dart';
import 'settings_screen.dart';
import 'package:logger/logger.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

enum NavigationItem { wallet, discover, settings }

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Call a method to fetch data and handle loading state
    return FutureBuilder(
      future: _fetchData(), // Method to fetch data
      builder: (context, snapshot) {
        // Show loading animation while fetching data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.inkDrop(
              color: Colors.white,
              size: 100,
            ),
          );
        }

        // Check for errors
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final wallet = snapshot.data; // Use the fetched wallet data

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
                          '\$${wallet.balance}',
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
              currentIndex: NavigationItem.wallet.index,
              onTap: (index) {
                _onBottomNavTapped(context, NavigationItem.values[index]);
              },
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _fetchData() async {
    // Simulating a network call to fetch wallet data
    await Future.delayed(const Duration(seconds: 2));
    return ApiData.wallet; // Return wallet data
  }

  void _onBottomNavTapped(BuildContext context, NavigationItem item) {
    switch (item) {
      case NavigationItem.wallet:
        // Navigate to Wallet
        break;
      case NavigationItem.discover:
        // Navigate to Discover
        break;
      case NavigationItem.settings:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
        break;
    }
  }

  // Helper method to build action buttons
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

  // Widget to build the Coins tab with the top crypto tokens
  Widget _buildCoinsTab() {
    final topTokens = ApiData.topTokens;
    Logger logger = Logger();
    logger.i(topTokens);

    return ListView.builder(
      itemCount: topTokens.length,
      itemBuilder: (context, index) {
        final token = topTokens[index];
        return ListTile(
          leading: token['imageUrl'] != null
              ? Image.network(
                  token['imageUrl']!,
                  width: 40,
                  height: 40,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                )
              : const Icon(Icons.image_not_supported),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  token['name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '${token['change']}%',
                style: TextStyle(
                  color: token['change'] >= 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: \$${token['price'].toStringAsFixed(2)}'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${token['currentAmount']}'),
                  Text('\$${token['currentBalance'].toStringAsFixed(2)}'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
