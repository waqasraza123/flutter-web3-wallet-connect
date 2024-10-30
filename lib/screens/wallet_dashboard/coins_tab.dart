import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_wallet_connect/services/moralis/wallet_token_balanaces_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';

class CoinsTab extends StatefulWidget {
  const CoinsTab({super.key});

  @override
  CoinsTabState createState() => CoinsTabState();
}

class CoinsTabState extends State<CoinsTab> {
  List<dynamic> tokens = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchTokens();
  }

  Future<void> fetchTokens() async {
    try {
      // Replace with the actual wallet address you want to fetch balances for
      final walletAddress = dotenv.env['ETH_WALLET_ADDRESS']!;
      final response =
          await WalletTokenBalanacesService.fetchWalletBalanaces(walletAddress);
      setState(() {
        tokens = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
      Logger().e('Error fetching tokens: $errorMessage');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: LoadingAnimationWidget.inkDrop(
          color: Colors.black,
          size: 50,
        ),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text('Error: $errorMessage'));
    }

    Logger logger = Logger();
    logger.i(tokens);

    return ListView.builder(
      itemCount: tokens.length,
      itemBuilder: (context, index) {
        final tokenData = tokens[index];
        final token = tokenData['token'];
        final amount = tokenData['value'];
        final tokenLogo = (token['logo']?.startsWith('ipfs://') ?? false)
            ? token['logo'].replaceFirst('ipfs://', 'https://ipfs.io/ipfs/')
            : (token['logo'] ??
                'https://cryptologos.cc/logos/ethereum-eth-logo.png?v=025');

        return ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.lightBlue,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0), // Adjust padding as needed
              child: ClipOval(
                child: Image.network(
                  tokenLogo,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return const Icon(Icons.image_not_supported,
                        size: 40, color: Colors.grey);
                  },
                ),
              ),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(token['name'] ?? token['symbol'] ?? 'Unknown Token',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              const Text(
                '', // Placeholder for additional info
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          subtitle: Text(
            'Amount: $amount ${token['symbol']}',
            style: const TextStyle(color: Colors.grey),
          ),
        );
      },
    );
  }
}
