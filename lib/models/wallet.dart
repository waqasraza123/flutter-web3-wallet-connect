class Token {
  final String name;
  final String symbol;
  final double amount;
  final double price;

  Token(
      {required this.name,
      required this.symbol,
      required this.amount,
      required this.price});
}

class NFT {
  final String name;
  final String imageUrl;

  NFT({required this.name, required this.imageUrl});
}

class Wallet {
  final double balance;
  final List<Token> tokens;
  final List<NFT> nfts;

  Wallet({required this.balance, required this.tokens, required this.nfts});
}
