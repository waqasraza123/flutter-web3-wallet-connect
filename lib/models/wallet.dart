import 'dart:convert';
import 'package:crypto/crypto.dart';

class Token {
  final String name;
  final String symbol;
  final double amount;
  final double price;

  Token({
    required this.name,
    required this.symbol,
    required this.amount,
    required this.price,
  });
}

class NFT {
  final String name;
  final String imageUrl;

  NFT({required this.name, required this.imageUrl});
}

class Wallet {
  final String recoveryPhrase;
  final String privateKey;
  final String publicKey;
  final String address; // Explicitly add address as a final field
  final double balance;
  final List<Token> tokens;
  final List<NFT> nfts;

  Wallet({
    required this.recoveryPhrase,
    required this.privateKey,
    required this.publicKey,
    required this.address, // Ensure address is set via the constructor
    required this.balance,
    required this.tokens,
    required this.nfts,
  });

  // Static method to derive the address from publicKey
  static String deriveAddress(String publicKey) {
    var bytes = utf8.encode(publicKey);
    var hash = sha256.convert(bytes);
    return '0x${hash.toString().substring(0, 40)}';
  }

  void addToken(Token token) {
    tokens.add(token);
  }

  void addNFT(NFT nft) {
    nfts.add(nft);
  }
}
