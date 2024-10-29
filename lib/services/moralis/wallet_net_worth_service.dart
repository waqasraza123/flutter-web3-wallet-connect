import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WalletNetWorthService {
  static Future<Map<String, dynamic>> fetchWalletNetWorth(
      String walletAddress) async {
    final baseUrl = dotenv.env['BASE_URL'];
    final url = '$baseUrl/api/web3/moralis/wallet/$walletAddress/net-worth';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load wallet net worth');
    }
  }
}
