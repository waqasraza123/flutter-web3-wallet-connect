import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../services/moralis/wallet_history_service.dart';
import 'package:logger/logger.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  List<dynamic> history = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    final response = await WalletHistoryService.fetchWalletHistory(
        dotenv.env['ETH_WALLET_ADDRESS']!);
    setState(() {
      history = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet History'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.black,
        child: isLoading
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: Colors.white, size: 50))
            : ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final transaction = history[index];
                  String amount = '0';
                  String symbol = 'ETH';
                  String address = '';
                  bool isSend = transaction['category'] == 'send';
                  String defaultLogo = '';

                  if (transaction['native_transfers'].isNotEmpty) {
                    final nativeTransfer = transaction['native_transfers'][0];
                    amount = nativeTransfer['value_formatted'] ?? '0';
                    symbol = nativeTransfer['token_symbol'] ?? 'ETH';
                    address = nativeTransfer['to_address'] ?? '';
                    if (nativeTransfer['token_logo'] != null) {
                      Logger logger = Logger();
                      defaultLogo = nativeTransfer['token_logo'];
                    }
                  } else if (transaction['erc20_transfers'].isNotEmpty) {
                    final erc20Transfer = transaction['erc20_transfers'][0];
                    amount = erc20Transfer['value_formatted'] ?? '0';
                    symbol = erc20Transfer['token_symbol'] ?? 'Token';
                    address = erc20Transfer['to_address'] ?? '';
                  } else {
                    amount = transaction['summary'] ?? 'Unknown';
                  }

                  return Card(
                    color: const Color(0xFF2B2B2B),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Logo with send/receive icon overlayed
                          Stack(
                            clipBehavior: Clip.none, // Allow overflow of icon
                            alignment: Alignment.bottomRight,
                            children: [
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.network(
                                  defaultLogo,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return Image.network(
                                      'https://via.placeholder.com/40',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: -5, // Adjust icon position
                                right: -5,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                        2), // Adjust padding for icon size
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(
                                          0.6), // Circle background color
                                    ),
                                    child: Icon(
                                      isSend
                                          ? Icons.arrow_forward_outlined
                                          : Icons.arrow_back_outlined,
                                      color: Colors.white.withOpacity(0.9),
                                      size:
                                          16, // Adjust icon size for better fit inside circle
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              width: 10), // Space between logo and text
                          // Transaction details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount: $amount $symbol',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'From: ${transaction['from_address']}',
                                  style: const TextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  'To: $address',
                                  style: const TextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
