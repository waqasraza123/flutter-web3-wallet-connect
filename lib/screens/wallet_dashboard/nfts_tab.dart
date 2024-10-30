import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import '../../services/moralis/wallet_nfts_service.dart';

class NFTsTab extends StatefulWidget {
  const NFTsTab({super.key});

  @override
  _NFTsTabState createState() => _NFTsTabState();
}

class _NFTsTabState extends State<NFTsTab> {
  late String walletAddress;

  @override
  void initState() {
    super.initState();
    walletAddress = dotenv.env['ETH_WALLET_ADDRESS'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: WalletNftsService.fetchWalletNFTs(walletAddress),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: LoadingAnimationWidget.inkDrop(
            color: Colors.black,
            size: 50,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
          return const Center(child: Text('No NFTs found'));
        } else {
          final nftData = snapshot.data!;

          return ListView.builder(
            itemCount: nftData.length,
            itemBuilder: (context, index) {
              final nft = nftData[index];
              final metadata = nft['metadata'] ?? {};
              final name = metadata['name'] ?? 'Unnamed NFT';
              final imageUrl = metadata['image'] ?? '';

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                        )
                      : const Icon(Icons.image),
                  title: Text(name),
                  subtitle: Text(nft['contractType'] ?? 'Unknown Type'),
                  onTap: () {
                    // Handle tap, e.g., show more details
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
