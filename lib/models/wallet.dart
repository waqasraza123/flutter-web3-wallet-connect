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
  final String recoveryPhrase; // Added for wallet creation
  final String privateKey; // Added for security
  final String publicKey; // Added for identification
  double balance;
  final List<Token> tokens;
  final List<NFT> nfts;

  Wallet({
    required this.recoveryPhrase,
    required this.privateKey,
    required this.publicKey,
    required this.balance,
    required this.tokens,
    required this.nfts,
  });

  // Method to add a token to the wallet
  void addToken(Token token) {
    tokens.add(token);
  }

  // Method to add an NFT to the wallet
  void addNFT(NFT nft) {
    nfts.add(nft);
  }

  // Method to update the balance
  void updateBalance(double amount) {
    balance += amount;
  }
}
