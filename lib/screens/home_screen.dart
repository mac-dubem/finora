import 'package:finora/screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:finora/constant.dart';
import 'package:finora/screens/finora_screen.dart';
import 'package:finora/services/database_service.dart';
import 'package:finora/widget/bottom_sheet_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This holds all the sheets created
  List<Map<String, dynamic>> sheets = [];
  // final TransactionManager manager = TransactionManager();

  @override
  void initState() {
    super.initState();
    _loadSheetsFromDb();
  }

  Future<void> _loadSheetsFromDb() async {
    final rows = await DBService.instance.getSheets();
    setState(() {
      // make mutable copies of native read-only DB rows
      sheets = rows.map((r) => Map<String, dynamic>.from(r)).toList();
    });
  }

  // Function to delete a sheet
  Future<void> deleteSheet(String id) async {
    try {
      // Delete from DB (persist)
      await DBService.instance.deleteSheet(id);
    } catch (e) {
      // ignore or log DB delete error
      debugPrint('deleteSheet db error: $e');
    }

    // Remove from UI
    setState(() {
      sheets.removeWhere((sheet) => sheet['id'] == id);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Sheet deleted')));
  }

  // final dbService = DBService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingPage()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: sheets.isEmpty
          ? Center(
              child: Container(
                height: 120,
                width: 300,
                decoration: BoxDecoration(                 
                  borderRadius: BorderRadius.circular(20),
                  // border: Border.all(
                  //   color: const Color(0xFF9E9E9E),
                  //   width: 1,
                  //   // style: BorderStyle.solid,
                  // ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "No Available Sheet. ",
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Click on the + button to add Sheet",
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...sheets.map((sheet) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FinoraScreen(sheetInfo: sheet),
                          ),
                        );
                      },
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                final id = sheet['id'].toString();
                                deleteSheet(id);
                              },
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(10),
                              ),
                            ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: myAppTheme.kContainerColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sheet['title'] ,
                                      // + " " + sheet["id"],
                                      // "Zenith Bank",
                                      style: TextStyle(
                                        color: myAppTheme.kContainerTextColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${sheet['currency']} ${sheet["amount"]}",
                                          style: TextStyle(
                                            color:
                                                myAppTheme.kContainerTextColor,
                                          ),
                                        ),
                                        // Text("\$200,000"),
                                        SizedBox(width: 10),
                                        Text(
                                          sheet['date'],
                                          style: TextStyle(
                                            color:
                                                myAppTheme.kContainerTextColor,
                                          ),
                                        ),
                                        // Text("Date"),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("2"),
                                    Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      size: 15,
                                      color: myAppTheme.kContainerTextColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
            String sheetId = DateTime.now().millisecondsSinceEpoch.toString();
            Map<String, dynamic> data = {
              "id": sheetId,
              "title": result['title'] ?? 'Untitled Sheet',
              "currency": result['currency'] ?? '₦',
              "amount": result['amount'] ?? '0.00',
              "date": result['date'] ?? '',
            };

            // persist sheet to DB
            try {
              await DBService.instance.createSheet(data);
              setState(() {
                // // Add to your list of sheets or display it
                // sheets.add(result); // ✅ this adds the new sheet data to your list
                // print(result); // You’ll later show this dynamically

                // sheets.add(sheet); // <-- add the map that includes id (was sheets.add(result))
                // ensure we operate on a mutable list copy
                sheets = List<Map<String, dynamic>>.from(sheets);
                sheets.add(data);
              });
            } catch (e) {
              print("error $e");
            }

            print(result);
            print(data);

            // open the new sheet screen immediately (passes sheetInfo)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FinoraScreen(sheetInfo: data),
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
