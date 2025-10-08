// import 'dart:io';
// import 'package:excel/excel.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// class ExportService {
  // Future<void> exportToExcel(List<Map<String, dynamic>> transactions) async {
  //   final excel = Excel.createExcel(); // Create a new Excel file
  //   final sheet = excel['Transactions']; // Create a sheet called Transactions

  //   sheet.appendRow(["Type", "Amount", "Category", "Description", "Date"]);

  //   for (var tx in transactions) {
  //     sheet.appendRow([
  //       tx["type"],
  //       tx["amount"],
  //       tx["category"],
  //       tx["description"],
  //       tx["date"].toString(),
  //     ]);
  //   }



  //   // Get storage directory
  //     final directory = await getApplicationDocumentsDirectory();
  //   final path = "${directory.path}/transactions.xlsx";


  //   // Save file
  //   final file = File(path);
  //   await file.writeAsBytes(excel.encode()!);

   
  //   print("✅ Excel saved at: $path");
  // }

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
