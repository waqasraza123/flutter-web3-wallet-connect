import 'package:flutter/material.dart';
import '../settings_screen.dart';
import '../wallet_history.dart';
import 'navigation_item.dart';
import 'package:logger/logger.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white, // Set the background color here
        primaryColor: Colors.blue, // Active item color
        textTheme: Theme.of(context).textTheme.copyWith(
              bodySmall:
                  const TextStyle(color: Colors.grey), // Inactive item color
            ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: NavigationItem.wallet.index,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) => _navigate(context, NavigationItem.values[index]),
      ),
    );
  }

  void _navigate(BuildContext context, NavigationItem item) {
    Logger logger = Logger();
    logger.i(item);
    switch (item) {
      case NavigationItem.wallet:
        // Navigate to Wallet screen
        break;
      case NavigationItem.discover:
        // Navigate to Discover screen
        break;
      case NavigationItem.history:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HistoryScreen()),
        );
        break;
      case NavigationItem.settings:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
        break;
    }
  }
}
