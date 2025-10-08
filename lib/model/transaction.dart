

class TransactionModel {
  final String category;      //
  final String description;   // name e.g. "Ice cream"
  final double amount;  // money value
  final String type;    // "income" or "expense"
  final DateTime date;  // when it happened

  TransactionModel({
    required this.category,
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
  });

   Map<String, dynamic> toMap() {
    return {
      // "id": id,
      "amount": amount,
      "type": type,
      "category": category,
      "description": description,
      "date": date.toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      // id: map["id"],
      amount: map["amount"],
      type: map["type"],
      category: map["category"],
      description: map["description"],
      date: DateTime.parse(map["date"]),
    );
  }
}
