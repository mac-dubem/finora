import 'package:finora/model/transaction.dart';
import 'package:finora/services/datebase_service.dart';

class TransactionManager {
  final List<TransactionModel> transactions = [];

  final DBService dbService = DBService.instance;

  // ================================================================
  // DATABASE FUNCTIONS
  // ================================================================

    // ================================================================
  // ADD TRANSACTION (saves to Firebase and updates local list)
  // ================================================================
  Future<void> addTransaction(TransactionModel transaction) async {
    // Add locally
    transactions.add(transaction);
    // Save to Firebase
    await dbService.insertTransaction(transaction);
  }

  // ================================================================
  // LOAD TRANSACTIONS (fetch from Firebase)
  // ================================================================
  Future<void> loadTransactions() async {
    final fetched = await dbService.getTransactions();
    transactions
      ..clear()
      ..addAll(fetched);
  }

  // ================================================================
  // MY APP CALCULATION
  // ================================================================
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
      .where((tx) => tx.type == "repayment")
      .fold(0.0, (sum, tx) => sum + tx.amount);

  double get outstandingLoan => totalLoan - totalLoanRepayment;

  double get balance => totalIncome - totalExpense;

  // ====================================================================
}
