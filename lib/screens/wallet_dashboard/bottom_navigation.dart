import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../settings_screen.dart';
import '../wallet_history.dart';
import 'navigation_item.dart';
import 'package:logger/logger.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.briefcase, color: Colors.black),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search, color: Colors.black),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.clock, color: Colors.black),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings, color: Colors.black),
          label: '',
        ),
      ],
      currentIndex: NavigationItem.wallet.index,
      selectedItemColor: Colors.black, // Change selected item color
      unselectedItemColor: Colors.grey, // Change unselected item color
      onTap: (index) => _navigate(context, NavigationItem.values[index]),
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
