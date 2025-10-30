// import 'dart:io';
// import 'package:excel/excel.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

class ExportServices {
  Future<void> exportIncomeAndExpense(
    List<Map<String, dynamic>> transactions,
  ) async {
    final filtered = transactions
        .where((tx) => tx["type"] == "income" || tx["type"] == "expense")
        .toList();

    List<String> headers = [
      "Type",
      "Amount",
      "Category",
      "Description",
      "Date",
    ];
    List<List<String>> rows = [];

    for (var tx in filtered) {
      rows.add([
        tx["type"].toString(),
        tx["amount"].toString(),
        tx["category"].toString(),
        tx["description"].toString(),
        DateFormat('yyyy-MM-dd – kk:mm').format(tx["date"]),
      ]);
    }

    await exportCSV.myCSV(headers, rows);
    log("Income and Expoxt expoxted sucessfully");
  }
}

// class ExportService {
//   Future<void> exportToExcel(List<Map<String, dynamic>> transactions) async {
//     final excel = Excel.createExcel(); // Create a new Excel file
//     final sheet = excel['Transactions']; // Create a sheet called Transactions

//     sheet.appendRow(["Type", "Amount", "Category", "Description", "Date"]);

//     for (var tx in transactions) {
//       sheet.appendRow([
//         tx["type"],
//         tx["amount"],
//         tx["category"],
//         tx["description"],
//         tx["date"].toString(),
//       ]);
//     }



//     // Get storage directory
//       final directory = await getApplicationDocumentsDirectory();
//     final path = "${directory.path}/transactions.xlsx";


//     // Save file
//     final file = File(path);
//     await file.writeAsBytes(excel.encode()!);

   
//     print("✅ Excel saved at: $path");
//   }

//    static Future<void> exportToPDF(
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
