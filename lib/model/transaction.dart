

class Transaction {
  final String category;      // unique ID for each transaction
  final String description;   // name e.g. "Ice cream"
  final double amount;  // money value
  final String type;    // "income" or "expense"
  final DateTime date;  // when it happened

  Transaction({
    required this.category,
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
  });
}