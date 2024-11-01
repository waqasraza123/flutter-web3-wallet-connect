import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WalletHistoryService {
  static Future<List<dynamic>> fetchWalletHistory(String walletAddress) async {
    final baseUrl = dotenv.env['BASE_URL'];
    if (baseUrl == null) {
      throw Exception('Base URL is not set in .env file');
    }
    final url = '$baseUrl/api/web3/moralis/wallet/$walletAddress/history';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load wallet history');
    }
  }
}
