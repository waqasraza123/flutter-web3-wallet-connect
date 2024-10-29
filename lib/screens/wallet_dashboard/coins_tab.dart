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

    return ListView.builder(
      itemCount: tokens.length,
      itemBuilder: (context, index) {
        final tokenData = tokens[index];
        final token = tokenData['token'];
        final amount = tokenData['value'];

        return ListTile(
          leading: token['logo'] != null
              ? Image.network(token['logo'], width: 40, height: 40)
              : const Icon(Icons.image_not_supported),
          title: Row(
            children: [
              Expanded(
                  child: Text(token['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold))),
              // You can customize how to display the token's price or change percentage here
              // Assuming price is not available in your API response, otherwise you can include it.
              const Text(
                'N/A', // Placeholder for price or any other info
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
