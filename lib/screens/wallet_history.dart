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

                  // Check for native transfers
                  if (transaction['native_transfers'].isNotEmpty) {
                    final nativeTransfer = transaction['native_transfers'][0];
                    amount = nativeTransfer['value_formatted'] ?? '0';
                    symbol = nativeTransfer['token_symbol'] ?? 'ETH';
                    address = nativeTransfer['to_address'] ?? '';
                    // Log token_logo if it's set
                    if (nativeTransfer['token_logo'] != null) {
                      Logger logger = Logger();
                      defaultLogo = nativeTransfer['token_logo'];
                    }
                  } else if (transaction['erc20_transfers'].isNotEmpty) {
                    // Check for ERC20 transfers
                    final erc20Transfer = transaction['erc20_transfers'][0];
                    amount = erc20Transfer['value_formatted'] ?? '0';
                    symbol = erc20Transfer['token_symbol'] ?? 'Token';
                    address = erc20Transfer['to_address'] ?? '';
                  } else {
                    // If there's no transfer, use the summary
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
                          // Chain logo placeholder
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.network(
                              defaultLogo,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return Image.network(
                                  'https://via.placeholder.com/40',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          // Amount sent and quantity
                          Expanded(
                            // Use Expanded or Flexible here
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
                                  overflow:
                                      TextOverflow.ellipsis, // Handle long text
                                  maxLines: 1, // Limit to one line
                                ),
                                Text(
                                  'To: $address',
                                  style: const TextStyle(color: Colors.white),
                                  overflow:
                                      TextOverflow.ellipsis, // Handle long text
                                  maxLines: 1, // Limit to one line
                                ),
                              ],
                            ),
                          ),
                          // Send or receive icon
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                isSend ? Icons.arrow_forward : Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ],
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
