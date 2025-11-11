import 'package:finora/model/transaction.dart';
import 'package:finora/services/database_service.dart';

class TransactionManager {
  final DBService dbService = DBService.instance;

  // Cache transactions per sheetId. Use empty string for "all" if needed.
  final Map<String, List<TransactionModel>> _sheetCache = {};

  // Optional: remember last loaded sheets id
  String? activeSheetId;

  // Return a safe immutable list for UI usage
  List<TransactionModel> transactionsFor(String? sheetId) {
    final key = (sheetId ?? '');
    final list = _sheetCache[key];
    return list == null ? [] : List.unmodifiable(list);
  }

  // Load transactions for a specific sheetId and cache them.
  // If sheetId is null or empty, load all transactions and cache under ''.

  Future<void> loadTransactionsForSheet(String? sheetId) async {
    final key = (sheetId ?? '');
    List<TransactionModel> fetched;
    if (key.isEmpty) {
      // Load all if no sheet provided
      fetched = await dbService.getTransactions();
    } else {
      // Load only those belonging to a specific sheet
      fetched = await dbService.getTransactionsForSheet(key);
    }

    // Store them in memory for quick access
    _sheetCache[key] = List<TransactionModel>.from(fetched);
    activeSheetId = key;
  }

  // ===============================
  // ADD NEW TRANSACTION (for sheet)
  // ===============================
  /// Adds a new transaction to both the database and memory cache.
  Future<void> addTransactionForSheet(
    TransactionModel transaction,
    String sheetId,
  ) async {
    final txWithSheet = TransactionModel(
      category: transaction.category,
      description: transaction.description,
      amount: transaction.amount,
      type: transaction.type,
      date: transaction.date,
      sheetId: sheetId,
    );

    // Save it in the database first
    await dbService.insertTransaction(txWithSheet);

    // Then update our in-memory cache
    final list = _sheetCache.putIfAbsent(sheetId, () => <TransactionModel>[]);
    list.insert(0, txWithSheet); // Add at top (newest first)
  }

  // ===================================
  // ADD TRANSACTION (no sheet provided)
  // ===================================

  /// Adds a transaction without a sheetId — for older logic or general use.
  // Backwards-compatible global add (no sheet)
  Future<void> addTransaction(TransactionModel transaction) async {
    await dbService.insertTransaction(transaction);

    final key = transaction.sheetId ?? '';
    final list = _sheetCache.putIfAbsent(key, () => <TransactionModel>[]);
    list.insert(0, transaction);
  }

  // ===============================
  // DELETE A TRANSACTION
  // ===============================

  /// Deletes a transaction by its [id] and updates the cache.
  Future<void> deleteTransaction(int id, {String? sheetId}) async {
    await dbService.deleteTransaction(id);

    final key = (sheetId ?? '');
    final list = _sheetCache[key];
    if (list != null) {
      list.removeWhere((t) => _idMatches(t, id));
    }
  }

  // ===============================
  // UPDATE A TRANSACTION
  // ===============================

  /// Updates a transaction in both DB and cache.
  Future<void> updateTransaction(
    int id,
    Map<String, dynamic> values, {
    String? sheetId,
  }) async {
    await dbService.updateTransaction(id, values);
    // Simplest: just reload the affected sheet to refresh data
    await loadTransactionsForSheet(sheetId);
  }

  bool _idMatches(TransactionModel t, int id) {
    // If your TransactionModel has no numeric id field, adapt this check.
    // For now attempt parse if map provided via toMap/fromMap had 'id'
    try {
      // unwrap via toMap if model contains id
      final map = t.toMap();
      if (map.containsKey('id')) {
        final v = map['id'];
        if (v is int) return v == id;
        if (v is String) return int.tryParse(v) == id;
      }
    } catch (_) {}
    return false;
  }

    // ================================================================
  // MY APP CALCULATION
  // ================================================================
  double totalIncome(String? sheetId) => _sumByType(sheetId, 'income');
  double totalExpense(String? sheetId) => _sumByType(sheetId, 'expense');
  double totalLoan(String? sheetId) => _sumByType(sheetId, 'loan');
  double totalLoanRepayment(String? sheetId) => _sumByType(sheetId, 'repayment');
  double outstandingLoan(String? sheetId) => totalLoan(sheetId) - totalLoanRepayment(sheetId);
  double balance(String? sheetId) => totalIncome(sheetId) - totalExpense(sheetId);

  double _sumByType(String? sheetId, String type) {
    final list = transactionsFor(sheetId);
    return list.where((t) => (t.type ?? '').toString().toLowerCase() == type).fold(0.0, (s, t) => s + (t.amount ?? 0));
  }
}

// class TransactionManager {
//   final List<TransactionModel> transactions = [];

//   final DBService dbService = DBService.instance;

//   // ================================================================
//   // DATABASE FUNCTIONS
//   // ================================================================

//   // ================================================================
//   // ADD TRANSACTION (saves to Firebase and updates local list)
//   // ================================================================
//   // Future<void> addTransaction(TransactionModel transaction) async {
//   //   // Add locally
//   //   transactions.add(transaction);
//   //   // Save to Firebase
//   //   await dbService.insertTransaction(transaction);
//   // }

//   Future<void> addTransactionForSheet(
//     TransactionModel transaction,
//     String sheetId,
//   ) async {
//     final txWithSheet = TransactionModel(
//       category: transaction.category,
//       description: transaction.description,
//       amount: transaction.amount,
//       type: transaction.type,
//       date: transaction.date,
//       sheetId: sheetId,
//     );
//     transactions.add(txWithSheet);
//     await dbService.insertTransaction(txWithSheet);
//   }

//   // legacy add (keeps backward compatibility)
//   Future<void> addTransaction(TransactionModel transaction) async {
//     transactions.add(transaction);
//     await dbService.insertTransaction(transaction);
//   }

//   // ================================================================
//   // LOAD TRANSACTIONS (fetch from Firebase)
//   // ================================================================
//   Future<void> loadTransactionsForSheet(String sheetId) async {
//     if (sheetId == null || sheetId.isEmpty) {
//      // load all transactions if no sheetId provided
//       final fetchedAll = await dbService.getTransactions();
//       transactions
//         ..clear()
//         ..addAll(fetchedAll);
//       return;
//     }

//     final fetched = await dbService.getTransactionsForSheet(sheetId);
//     transactions
//       ..clear()
//       ..addAll(fetched);
//   }

//   // ================================================================
//   // MY APP CALCULATION
//   // ================================================================
//   double get totalIncome => transactions
//       .where((tx) => tx.type == "income")
//       .fold(0.0, (sum, tx) => sum + tx.amount);

//   double get totalExpense => transactions
//       .where((tx) => tx.type == "expense")
//       .fold(0.0, (sum, tx) => sum + tx.amount);

//   double get totalLoan => transactions
//       .where((tx) => tx.type == "loan")
//       .fold(0.0, (sum, tx) => sum + tx.amount);

//   double get totalLoanRepayment => transactions
//       .where((tx) => tx.type == "repayment")
//       .fold(0.0, (sum, tx) => sum + tx.amount);

//   double get outstandingLoan => totalLoan - totalLoanRepayment;

//   double get balance => totalIncome - totalExpense;

//   // ====================================================================
// }
