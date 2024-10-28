import '../models/wallet.dart';
import '../models/transaction.dart';

class ApiData {
  static final Wallet wallet = Wallet(
    balance: 1500.00,
    tokens: [
      Token(name: "Ethereum", symbol: "ETH", amount: 1.5, price: 3000.00),
      Token(name: "Binance Coin", symbol: "BNB", amount: 2.0, price: 400.00),
      Token(name: "Solana", symbol: "SOL", amount: 10.0, price: 20.00),
    ],
    nfts: [
      NFT(name: "CryptoPunk #1", imageUrl: "https://example.com/nft1.png"),
      NFT(name: "Bored Ape #2", imageUrl: "https://example.com/nft2.png"),
    ],
  );

  static final List<Transaction> transactions = [
    Transaction(
        id: "1",
        amount: -50.00,
        date: DateTime.now().subtract(const Duration(days: 1)),
        type: "Sent"),
    Transaction(
        id: "2",
        amount: 150.00,
        date: DateTime.now().subtract(const Duration(days: 2)),
        type: "Received"),
    Transaction(
        id: "3",
        amount: -20.00,
        date: DateTime.now().subtract(const Duration(days: 3)),
        type: "Sent"),
  ];
}
