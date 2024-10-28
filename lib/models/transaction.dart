class Transaction {
  final String id;
  final String walletId;
  final double amount;
  final String date;

  Transaction(
      {required this.id,
      required this.walletId,
      required this.amount,
      required this.date});
}
