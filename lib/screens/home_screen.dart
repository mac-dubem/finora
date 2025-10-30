import 'package:flutter/material.dart';
import 'package:finora/constant.dart';
import 'package:finora/screens/finora_screen.dart';
import 'package:finora/services/database_service.dart';
import 'package:finora/widget/bottom_sheet_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This holds all the sheets created
  List<Map<String, dynamic>> sheets = [];

  // final dbService = DBService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SHEETS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: myAppTheme.kContainerTextColor,
              ),
            ),
            ...sheets.map((sheet) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinoraScreen(sheetInfo: sheet),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black12,
                    //     blurRadius: 4,
                    //     offset: Offset(0, 2),
                    //   ),
                    // ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sheet['title'],
                              // "Zenith Bank",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${sheet['currency']} ${sheet["amount"]}",
                                  // style: ,
                                ),
                                // Text("\$200,000"),
                                SizedBox(width: 10),
                                Text(sheet['date']),
                                // Text("Date"),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("2"),
                            Icon(Icons.arrow_forward_ios_sharp, size: 15),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showModalBottomSheet<Map<String, dynamic>>(
            isScrollControlled: true,

            useSafeArea: true,
            context: context,
            builder: (context) => NewSheetBottomPopup(),
          );
          if (result != null) {
            // create unique id
            final sheetId = DateTime.now().millisecondsSinceEpoch.toString();
            final sheet = {
              "id": sheetId,
              "title": result['title'] ?? 'Untitled Sheet',
              "currency": result['currency'] ?? '₦',
              "amount": result['amount'] ?? '0.00',
              "date": result['date'] ?? '',
            };

            // persist sheet to DB
            try {
              await DBService.instance.createSheet(sheet);
            } catch (e) {
              // ignore or handle
            }

            setState(() {
              // Add to your list of sheets or display it
              sheets.add(result); // ✅ this adds the new sheet data to your list
              print(result); // You’ll later show this dynamically
            });

            // open the new sheet screen immediately (passes sheetInfo)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FinoraScreen(sheetInfo: sheet),
              ),
            );
          }
        },

        shape: CircleBorder(),
        backgroundColor: myAppTheme.kButtonColor,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}

// =====================================================================================
