// import 'dart:io';
// import 'package:csv/csv.dart';
// // import 'package:path_provider/path_provider.dart';

// // Future<void> exportToCSV(List<Map<String, dynamic>> transactions) async {
// //   // Convert transactions into rows
// //   List<List<dynamic>> rows = [
// //     ["Type", "Amount", "Category", "Description", "Date"], // header row
// //   ];

// //   for (var tx in transactions) {
// //     rows.add([
// //       tx["type"],
// //       tx["amount"],
// //       tx["category"],
// //       tx["description"],
// //       tx["date"].toString(),
// //     ]);
// //   }

// //   // Convert rows to CSV string
// //   String csv = const ListToCsvConverter().convert(rows);

// //   // Get storage directory
// //   final directory = await getApplicationDocumentsDirectory();
// //   final path = "${directory.path}/transactions.csv";

// //   // Save file
// //   final file = File(path);
// //   await file.writeAsString(csv);

// //   print("✅ CSV saved at: $path");
// // }





// //   // Export PDF
// //   Future<void> exportToPDF(
// //       List<Map<String, dynamic>> transactions, String filename) async {
// //     final pdf = pw.Document();

// //     pdf.addPage(
// //       pw.Page(
// //         build: (pw.Context context) {
// //           return pw.Table.fromTextArray(
// //             headers: ["Type", "Amount", "Category", "Description", "Date"],
// //             data: transactions.map((tx) => [
// //               tx["type"],
// //               tx["amount"].toString(),
// //               tx["category"],
// //               tx["description"],
// //               tx["date"].toString(),
// //             ]).toList(),
// //           );
// //         },
// //       ),
// //     );

// //     final dir = await getApplicationDocumentsDirectory();
// //     final path = "${dir.path}/$filename.pdf";
// //     final file = File(path);
// //     await file.writeAsBytes(await pdf.save());

// //     await Share.shareXFiles([XFile(path)], text: "Exported $filename report 📄");
// //   }


// import 'dart:io';
// // import 'package:excel/excel.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/widgets.dart' as pw;
// // import 'package:share_plus/share_plus.dart';

// class ExportService {
//   // Export Excel
// Future<void> exportToCSV(List<Map<String, dynamic>> transactions) async {
//   // Convert transactions into rows
//   List<List<dynamic>> rows = [
//     ["Type", "Amount", "Category", "Description", "Date"], // header row
//   ];

//   for (var tx in transactions) {
//     rows.add([
//       tx["type"],
//       tx["amount"],
//       tx["category"],
//       tx["description"],
//       tx["date"].toString(),
//     ]);
//   }

//   // Convert rows to CSV string
//   String csv = const ListToCsvConverter().convert(rows);

//   // Get storage directory
//   final directory = await getApplicationDocumentsDirectory();
//   final path = "${directory.path}/transactions.csv";

//   // Save file
//   final file = File(path);
//   await file.writeAsString(csv);

//   print("✅ CSV saved at: $path");
// }

//   // Export PDF
//   static Future<void> exportToPDF(
//       List<Map<String, dynamic>> transactions, String filename) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Table.fromTextArray(
//             headers: ["Type", "Amount", "Category", "Description", "Date"],
//             data: transactions.map((tx) => [
//               tx["type"],
//               tx["amount"].toString(),
//               tx["category"],
//               tx["description"],
//               tx["date"].toString(),
//             ]).toList(),
//           );
//         },
//       ),
//     );

//     final dir = await getApplicationDocumentsDirectory();
//     final path = "${dir.path}/$filename.pdf";
//     final file = File(path);
//     await file.writeAsBytes(await pdf.save());

//     await Share.shareXFiles([XFile(path)], text: "Exported $filename report 📄");
//   }
// }


// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(const ExpenseApp());
// // }

// // class ExpenseApp extends StatelessWidget {
// //   const ExpenseApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Expense Tracker',
// //       theme: ThemeData(primarySwatch: Colors.blue),
// //       home: const HomePage(),
// //     );
// //   }
// // }

// // class HomePage extends StatefulWidget {
// //   const HomePage({super.key});

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   final List<Map<String, dynamic>> _transactions = [];

// //   final _titleController = TextEditingController();
// //   final _amountController = TextEditingController();
// //   String _selectedType = "expense"; // default

// //   // Add a transaction
// //   void _addTransaction() {
// //     if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;

// //     setState(() {
// //       _transactions.add({
// //         "title": _titleController.text,
// //         "amount": double.tryParse(_amountController.text) ?? 0,
// //         "type": _selectedType,
// //         "date": DateTime.now(),
// //       });
// //     });

// //     _titleController.clear();
// //     _amountController.clear();
// //   }

// //   // Calculate totals
// //   double get totalIncome => _transactions
// //       .where((tx) => tx["type"] == "income")
// //       .fold(0.0, (sum, tx) => sum + tx["amount"]);

// //   double get totalExpense => _transactions
// //       .where((tx) => tx["type"] == "expense")
// //       .fold(0.0, (sum, tx) => sum + tx["amount"]);

// //   double get balance => totalIncome - totalExpense;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Expense Tracker")),
// //       body: Column(
// //         children: [
// //           // Summary box
// //           Card(
// //             margin: const EdgeInsets.all(10),
// //             child: Padding(
// //               padding: const EdgeInsets.all(15),
// //               child: Column(
// //                 children: [
// //                   Text("Income: ₦${totalIncome.toStringAsFixed(2)}",
// //                       style: const TextStyle(color: Colors.green, fontSize: 16)),
// //                   Text("Expense: ₦${totalExpense.toStringAsFixed(2)}",
// //                       style: const TextStyle(color: Colors.red, fontSize: 16)),
// //                   Text("Balance: ₦${balance.toStringAsFixed(2)}",
// //                       style: const TextStyle(
// //                           color: Colors.blue,
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold)),
// //                 ],
// //               ),
// //             ),
// //           ),

// //           // Input fields
// //           Padding(
// //             padding: const EdgeInsets.all(8),
// //             child: Column(
// //               children: [
// //                 TextField(
// //                   controller: _titleController,
// //                   decoration: const InputDecoration(labelText: "Title"),
// //                 ),
// //                 TextField(
// //                   controller: _amountController,
// //                   decoration: const InputDecoration(labelText: "Amount"),
// //                   keyboardType: TextInputType.number,
// //                 ),
// //                 DropdownButton<String>(
// //                   value: _selectedType,
// //                   items: const [
// //                     DropdownMenuItem(value: "expense", child: Text("Expense")),
// //                     DropdownMenuItem(value: "income", child: Text("Income")),
// //                   ],
// //                   onChanged: (val) {
// //                     setState(() {
// //                       _selectedType = val!;
// //                     });
// //                   },
// //                 ),
// //                 ElevatedButton(
// //                   onPressed: _addTransaction,
// //                   child: const Text("Add Transaction"),
// //                 )
// //               ],
// //             ),
// //           ),

// //           const SizedBox(height: 10),

// //           // Transaction list
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: _transactions.length,
// //               itemBuilder: (ctx, index) {
// //                 final tx = _transactions[index];
// //                 return ListTile(
// //                   title: Text(tx["title"]),
// //                   subtitle: Text("${tx["date"]}"),
// //                   trailing: Text(
// //                     "${tx["type"] == "expense" ? "-" : "+"}₦${tx["amount"]}",
// //                     style: TextStyle(
// //                       color: tx["type"] == "expense"
// //                           ? Colors.red
// //                           : Colors.green,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }



// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(const ExpenseApp());
// // }

// // class ExpenseApp extends StatelessWidget {
// //   const ExpenseApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Expense Tracker',
// //       theme: ThemeData(primarySwatch: Colors.blue),
// //       home: const HomePage(),
// //       debugShowCheckedModeBanner: false,
// //     );
// //   }
// // }

// // // 🟢 Transaction Model
// // class Transaction {
// //   final String title;
// //   final double amount;
// //   final String type; // "income", "expense", "loan", "loanRepayment"
// //   final DateTime date;

// //   Transaction({
// //     required this.title,
// //     required this.amount,
// //     required this.type,
// //     required this.date,
// //   });
// // }

// // // 🟢 Home Page
// // class HomePage extends StatefulWidget {
// //   const HomePage({super.key});

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   final List<Transaction> _transactions = [];

// //   final _titleController = TextEditingController();
// //   final _amountController = TextEditingController();
// //   String _selectedType = "expense"; // default

// //   // ➕ Add a transaction
// //   void _addTransaction() {
// //     if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;

// //     setState(() {
// //       _transactions.add(
// //         Transaction(
// //           title: _titleController.text,
// //           amount: double.tryParse(_amountController.text) ?? 0,
// //           type: _selectedType,
// //           date: DateTime.now(),
// //         ),
// //       );
// //     });

// //     _titleController.clear();
// //     _amountController.clear();
// //   }

// //   // 📊 Getters for totals
// //   double get totalIncome => _transactions
// //       .where((tx) => tx.type == "income")
// //       .fold(0.0, (sum, tx) => sum + tx.amount);

// //   double get totalExpense => _transactions
// //       .where((tx) => tx.type == "expense")
// //       .fold(0.0, (sum, tx) => sum + tx.amount);

// //   double get totalLoan => _transactions
// //       .where((tx) => tx.type == "loan")
// //       .fold(0.0, (sum, tx) => sum + tx.amount);

// //   double get totalLoanRepayment => _transactions
// //       .where((tx) => tx.type == "loanRepayment")
// //       .fold(0.0, (sum, tx) => sum + tx.amount);

// //   double get outstandingLoan => totalLoan - totalLoanRepayment;

// //   // 💰 Balance (Option A: include loans and repayments)
// //   double get balance =>
// //       (totalIncome + totalLoan) - (totalExpense + totalLoanRepayment);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Expense Tracker")),
// //       body: Column(
// //         children: [
// //           // 📊 Totals Section
// //           Card(
// //             margin: const EdgeInsets.all(8),
// //             child: Padding(
// //               padding: const EdgeInsets.all(12),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text("Income: ₦${totalIncome.toStringAsFixed(2)}"),
// //                   Text("Expense: ₦${totalExpense.toStringAsFixed(2)}"),
// //                   Text("Loan Taken: ₦${totalLoan.toStringAsFixed(2)}"),
// //                   Text("Loan Repaid: ₦${totalLoanRepayment.toStringAsFixed(2)}"),
// //                   Text("Outstanding Loan: ₦${outstandingLoan.toStringAsFixed(2)}"),
// //                   const Divider(),
// //                   Text(
// //                     "Balance: ₦${balance.toStringAsFixed(2)}",
// //                     style: const TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 18,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),

// //           // ➕ Add Transaction Inputs
// //           Padding(
// //             padding: const EdgeInsets.all(8),
// //             child: Column(
// //               children: [
// //                 TextField(
// //                   controller: _titleController,
// //                   decoration: const InputDecoration(labelText: "Title"),
// //                 ),
// //                 TextField(
// //                   controller: _amountController,
// //                   keyboardType: TextInputType.number,
// //                   decoration: const InputDecoration(labelText: "Amount"),
// //                 ),
// //                 DropdownButton<String>(
// //                   value: _selectedType,
// //                   items: const [
// //                     DropdownMenuItem(value: "income", child: Text("Income")),
// //                     DropdownMenuItem(value: "expense", child: Text("Expense")),
// //                     DropdownMenuItem(value: "loan", child: Text("Loan")),
// //                     DropdownMenuItem(
// //                         value: "loanRepayment", child: Text("Loan Repayment")),
// //                   ],
// //                   onChanged: (val) {
// //                     setState(() {
// //                       _selectedType = val!;
// //                     });
// //                   },
// //                 ),
// //                 ElevatedButton(
// //                   onPressed: _addTransaction,
// //                   child: const Text("Add Transaction"),
// //                 ),
// //               ],
// //             ),
// //           ),

// //           // 📃 Transaction List
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: _transactions.length,
// //               itemBuilder: (ctx, index) {
// //                 final tx = _transactions[index];
// //                 return ListTile(
// //                   leading: CircleAvatar(
// //                     child: Text(tx.type[0].toUpperCase()),
// //                   ),
// //                   title: Text(tx.title),
// //                   subtitle: Text(
// //                       "${tx.type} • ${tx.date.toLocal().toString().split(' ')[0]}"),
// //                   trailing: Text("₦${tx.amount.toStringAsFixed(2)}"),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
