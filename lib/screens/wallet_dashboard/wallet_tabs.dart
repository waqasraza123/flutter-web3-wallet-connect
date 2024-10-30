import 'package:flutter/material.dart';
import 'coins_tab.dart';
import 'nfts_tab.dart';

class WalletTabs extends StatelessWidget {
  const WalletTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TabBar(
          tabs: [
            Tab(text: 'Coins'),
            Tab(text: 'NFTs'),
          ],
        ),
        SizedBox(
          height: 500,
          child: TabBarView(
            children: [
              CoinsTab(),
              NFTsTab(),
            ],
          ),
        ),
      ],
    );
  }
}
