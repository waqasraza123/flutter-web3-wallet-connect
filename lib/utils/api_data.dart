import '../models/wallet.dart';
import '../models/transaction.dart';

class ApiData {
  static final Wallet wallet = Wallet(
    recoveryPhrase: "your recovery phrase here",
    privateKey: "your private key here",
    publicKey: "your public key here",
    address: "your derived address here",
    balance: 1500.00,
    tokens: [
      Token(
        name: "Ethereum",
        symbol: "ETH",
        amount: 1.5,
        price: 3000.00,
        imageUrl: 'https://cryptologos.cc/logos/ethereum-eth-logo.png?v=025',
        currentAmount: 1.5,
        currentBalance: 3000.00 * 1.5,
      ),
      Token(
        name: "Binance Coin",
        symbol: "BNB",
        amount: 2.0,
        price: 400.00,
        imageUrl:
            'https://cryptologos.cc/logos/binance-coin-bnb-logo.png?v=025',
        currentAmount: 2.0,
        currentBalance: 400.00 * 2.0,
      ),
      Token(
        name: "Solana",
        symbol: "SOL",
        amount: 10.0,
        price: 20.00,
        imageUrl: 'https://cryptologos.cc/logos/solana-sol-logo.png?v=025',
        currentAmount: 10.0,
        currentBalance: 20.00 * 10.0,
      ),
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
      type: "Sent",
    ),
    Transaction(
      id: "2",
      amount: 150.00,
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: "Received",
    ),
    Transaction(
      id: "3",
      amount: -20.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
      type: "Sent",
    ),
  ];

  static List<Map<String, dynamic>> get topTokens {
    return wallet.tokens.map((token) {
      return {
        'name': token.name,
        'price': token.price,
        'change': 0.0,
        'imageUrl': token.imageUrl,
        'currentAmount': token.currentAmount,
        'currentBalance': token.currentBalance,
      };
    }).toList();
  }
}
