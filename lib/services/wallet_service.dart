import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bip39/bip39.dart' as bip39;

import '../models/wallet.dart';

class WalletService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Wallet createWallet() {
    final recoveryPhrase = bip39.generateMnemonic();
    final seed = bip39.mnemonicToSeed(recoveryPhrase);
    final privateKey = _derivePrivateKey(seed);
    final publicKey = _derivePublicKey(privateKey);
    final address = Wallet.deriveAddress(publicKey);

    return Wallet(
      recoveryPhrase: recoveryPhrase,
      privateKey: privateKey,
      publicKey: publicKey,
      address: address,
      balance: 0.0,
      tokens: [],
      nfts: [],
    );
  }

  String _derivePrivateKey(List<int> seed) {
    return seed
        .sublist(0, 32)
        .map((e) => e.toRadixString(16).padLeft(2, '0'))
        .join();
  }

  String _derivePublicKey(String privateKey) {
    return privateKey; // Placeholder for public key derivation
  }

  Future<void> saveWallet(Wallet wallet) async {
    await _storage.write(key: 'recoveryPhrase', value: wallet.recoveryPhrase);
    await _storage.write(key: 'privateKey', value: wallet.privateKey);
    await _storage.write(key: 'publicKey', value: wallet.publicKey);
    await _storage.write(
        key: 'address', value: wallet.address); // Store address
    await _storage.write(key: 'balance', value: wallet.balance.toString());
  }
}
