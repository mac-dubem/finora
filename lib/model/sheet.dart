// import 'dart:collection';

// import 'package:finora/model/transaction.dart';
// import 'package:finora/services/database_service.dart';

// class TransactionManager {
//   final DBService dbService = DBService.instance;

//   // Cache transactions per sheetId. Use empty string key '' to represent "all transactions".
//   final Map<String, List<TransactionModel>> _sheetCache = {};

//   // Optionally remember which sheet was last active
//   String? activeSheetId;

//   TransactionManager();

//   // Return an immutable view of transactions for a sheet
//   List<TransactionModel> transactionsFor(String? sheetId) {
//     final key = sheetId ?? '';
//     final list = _sheetCache[key];
//     if (list == null) return const [];
//     return UnmodifiableListView(list);
//   }

//   // Load transactions for a specific sheetId and cache them.
//   // If sheetId is null or empty -> load all transactions and cache under key ''
//   Future<void> loadTransactionsForSheet(String? sheetId) async {
//     final key = (sheetId ?? '');
//     List<TransactionModel> fetched;
//     if (key.isEmpty) {
//       fetched = await dbService.getTransactions();
//     } else {
//       fetched = await dbService.getTransactionsForSheet(key);
//     }
//     // store a mutable dart list copy
//     _sheetCache[key] = List<TransactionModel>.from(fetched);
//     activeSheetId = key;
//   }

//   // Persist a transaction tied to a sheet, then update the sheet cache.
//   Future<void> addTransactionForSheet(TransactionModel transaction, String sheetId) async {
//     final txToSave = TransactionModel(
//       category: transaction.category,
//       description: transaction.description,
//       amount: transaction.amount,
//       type: transaction.type,
//       date: transaction.date,
//       sheetId: sheetId,
//     );

//     await dbService.insertTransaction(txToSave);

//     final list = _sheetCache.putIfAbsent(sheetId, () => <TransactionModel>[]);
//     list.insert(0, txToSave);
//   }

//   // Backwards compatible: add transaction without explicit sheetId
//   Future<void> addTransaction(TransactionModel transaction) async {
//     await dbService.insertTransaction(transaction);
//     final key = transaction.sheetId ?? '';
//     final list = _sheetCache.putIfAbsent(key, () => <TransactionModel>[]);
//     list.insert(0, transaction);
//   }

//   // Delete transaction (by DB id if you add id field to model) - simple cache update by matching unique fields
//   Future<void> deleteTransactionByPredicate(bool Function(TransactionModel) predicate, {String? sheetId}) async {
//     // Note: DB delete should be implemented in DBService with the id; this method updates cache to stay consistent.
//     final key = (sheetId ?? '');
//     final list = _sheetCache[key];
//     if (list != null) {
//       list.removeWhere(predicate);
//     }
//   }

//   // Reload a sheet (convenience)
//   Future<void> reloadSheet(String? sheetId) async => await loadTransactionsForSheet(sheetId);

//   // Per-sheet getters
//   double totalIncome(String? sheetId) => _sumByType(sheetId, 'income');
//   double totalExpense(String? sheetId) => _sumByType(sheetId, 'expense');
//   double totalLoan(String? sheetId) => _sumByType(sheetId, 'loan');
//   double totalLoanRepayment(String? sheetId) => _sumByType(sheetId, 'repayment');
//   double outstandingLoan(String? sheetId) => totalLoan(sheetId) - totalLoanRepayment(sheetId);
//   double balance(String? sheetId) => totalIncome(sheetId) - totalExpense(sheetId);

//   double _sumByType(String? sheetId, String type) {
//     final list = transactionsFor(sheetId);
//     return list.where((t) => (t.type ?? '').toString().toLowerCase() == type).fold(0.0, (s, t) => s + (t.amount));
//   }
// }




// // ...existing code...
// import 'package:finora/model/transaction.dart';
// import 'package:finora/services/database_service.dart';

// class TransactionManager {
//   final DBService dbService = DBService.instance;

//   // Cache transactions per sheetId. Use empty string for "all" if needed.
//   final Map<String, List<TransactionModel>> _sheetCache = {};

//   // Optional: remember last loaded sheet id
//   String? activeSheetId;

//   // Return a safe immutable list for UI usage
//   List<TransactionModel> transactionsFor(String? sheetId) {
//     final key = (sheetId ?? '');
//     final list = _sheetCache[key];
//     return list == null ? [] : List.unmodifiable(list);
//   }

//   // Load transactions for a specific sheetId and cache them.
//   // If sheetId is null or empty, load all transactions and cache under ''.
//   Future<void> loadTransactionsForSheet(String? sheetId) async {
//     final key = (sheetId ?? '');
//     List<TransactionModel> fetched;
//     if (key.isEmpty) {
//       fetched = await dbService.getTransactions();
//     } else {
//       fetched = await dbService.getTransactionsForSheet(key);
//     }
//     // ensure we store mutable Dart list
//     _sheetCache[key] = List<TransactionModel>.from(fetched);
//     activeSheetId = key;
//   }

//   // Add a transaction and keep cache in sync (insert at front to keep newest first).
//   Future<void> addTransactionForSheet(TransactionModel transaction, String sheetId) async {
//     final txWithSheet = TransactionModel(
//       category: transaction.category,
//       description: transaction.description,
//       amount: transaction.amount,
//       type: transaction.type,
//       date: transaction.date,
//       sheetId: sheetId,
//     );

//     // Persist first
//     await dbService.insertTransaction(txWithSheet);

//     // Update cache
//     final list = _sheetCache.putIfAbsent(sheetId, () => <TransactionModel>[]);
//     list.insert(0, txWithSheet);
//   }

//   // Backwards-compatible global add (no sheet)
//   Future<void> addTransaction(TransactionModel transaction) async {
//     await dbService.insertTransaction(transaction);
//     final key = transaction.sheetId ?? '';
//     final list = _sheetCache.putIfAbsent(key, () => <TransactionModel>[]);
//     list.insert(0, transaction);
//   }

//   // Update/delete helpers (keep cache & DB consistent)
//   Future<void> deleteTransaction(int id, {String? sheetId}) async {
//     await dbService.deleteTransaction(id);
//     final key = (sheetId ?? '');
//     final list = _sheetCache[key];
//     if (list != null) {
//       list.removeWhere((t) => (t is TransactionModel) && _idMatches(t, id));
//     }
//   }

//   Future<void> updateTransaction(int id, Map<String, dynamic> values, {String? sheetId}) async {
//     await dbService.updateTransaction(id, values);
//     // simplest: reload affected sheet
//     await loadTransactionsForSheet(sheetId);
//   }

//   bool _idMatches(TransactionModel t, int id) {
//     // If your TransactionModel has no numeric id field, adapt this check.
//     // For now attempt parse if map provided via toMap/fromMap had 'id'
//     try {
//       // unwrap via toMap if model contains id
//       final map = t.toMap();
//       if (map.containsKey('id')) {
//         final v = map['id'];
//         if (v is int) return v == id;
//         if (v is String) return int.tryParse(v) == id;
//       }
//     } catch (_) {}
//     return false;
//   }

//   // Per-sheet getters
//   double totalIncome(String? sheetId) => _sumByType(sheetId, 'income');
//   double totalExpense(String? sheetId) => _sumByType(sheetId, 'expense');
//   double totalLoan(String? sheetId) => _sumByType(sheetId, 'loan');
//   double totalLoanRepayment(String? sheetId) => _sumByType(sheetId, 'repayment');
//   double outstandingLoan(String? sheetId) => totalLoan(sheetId) - totalLoanRepayment(sheetId);
//   double balance(String? sheetId) => totalIncome(sheetId) - totalExpense(sheetId);

//   double _sumByType(String? sheetId, String type) {
//     final list = transactionsFor(sheetId);
//     return list.where((t) => (t.type ?? '').toString().toLowerCase() == type).fold(0.0, (s, t) => s + (t.amount ?? 0));
//   }
// }
// // ...existing code...