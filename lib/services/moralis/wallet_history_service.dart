import 'dart:convert';
import 'package:http/http.dart' as http;

class WalletHistoryService {
  static Future<List<dynamic>> fetchWalletHistory(String walletAddress) async {
    final url =
        'https://4d89-223-123-23-32.ngrok-free.app/api/web3/moralis/wallet/$walletAddress/history';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load wallet history');
    }
  }
}
