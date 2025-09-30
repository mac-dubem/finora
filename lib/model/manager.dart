import 'package:finora/model/transaction.dart';

class TransactionManager {
  final List<Transaction> transactions = [];

  double get totalIncome => transactions
      .where((tx) => tx.type == "income")
      .fold(0.0, (sum, tx) => sum + tx.amount);

  double get totalExpense => transactions
      .where((tx) => tx.type == "expense")
      .fold(0.0, (sum, tx) => sum + tx.amount);

  double get totalLoan => transactions
      .where((tx) => tx.type == "loan")
      .fold(0.0, (sum, tx) => sum + tx.amount);

  double get totalLoanRepayment => transactions
      .where((tx) => tx.type == "loanRepayment")
      .fold(0.0, (sum, tx) => sum + tx.amount);

  double get balance => totalIncome - totalExpense;
}