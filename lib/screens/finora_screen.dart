import 'package:finora/constant.dart';
import 'package:finora/model/manager.dart';
// import 'package:finora/model/sheet.dart' ;
import 'package:finora/model/transaction.dart';
import 'package:finora/widget/action_button.dart';
import 'package:finora/widget/dropdown_widget.dart';
import 'package:finora/widget/history_container.dart';
import 'package:finora/widget/input_widget.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinoraScreen extends StatefulWidget {
  const FinoraScreen({super.key});

  @override
  State<FinoraScreen> createState() => _FinoraScreenState();
}

class _FinoraScreenState extends State<FinoraScreen> {
  // =================================================================
  int selectedTab = 0;
  List<String> appTab = ["Add Transaction", "Loan", "History"];
  // ==================================================================

  // ==================== DROPDROWN LIST ==============================
  // String? selectedType;
  List<String> typeDropdown = ["Expense", "Income ", "Loan", "Repayment"];

  // String? selectedCategory;
  final List<String> categoryDropdown = [
    "Foods & Dining",
    "Transportation",
    "Shopping",
    "Bills & Utilities",
    "Entertainment",
    "Health & Medical",
    "Other",
  ];

  // ==================================================================
  final TransactionManager manager = TransactionManager();
  // final List<Map<String, dynamic>> transactions = [];
  // final List<Transaction> transactions = [];

  final descController = TextEditingController();
  final amountController = TextEditingController();
  String? selectedType;
  String? selectedCategory;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Expense Tracker",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 30,
                ),
                child: Column(
                  spacing: 10,
                  children: [
                    Text(
                      "Current Balance",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      "\$146,500.00",
                      // "₦${balance.toStringAsFixed(2)"}
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),

                    contaninerIncomeText(
                      title1: "Income",
                      amount1: "\$150,000.00",
                      title2: "Expenses",
                      amount2: "\$3,500",
                    ),
                    contaninerIncomeText(
                      title1: "Loans Given",
                      amount1: "\$0.00",
                      title2: "Loans Owed",
                      amount2: "\$0.00",
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            // =====================================================================
            // PAGE TAB BAR
            // =====================================================================
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(appTab.length, (index) {
                    bool isSelected = selectedTab == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Colors.red
                        ),
                        child: Center(
                          child: Text(
                            appTab[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected
                                  ? Colors.blue[900]
                                  : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            // =============================================================================

            // ================================================================================
            // ADD TRANSACTION SECTION
            // ================================================================================
            if (selectedTab == 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==========================================================
                  sectionHeader(title: "Type"),
                  DropDownWidget(
                    selectedDrop: selectedType,
                    dropdownList: typeDropdown,
                    onChanged: (val) {
                      setState(() {
                        selectedType = val;
                      });
                    },
                    hintText: "Select Type",
                  ),
                  // =============================================================
                  // Text("Amount (\$)", style: sectionTitleStyle),
                  sectionHeader(title: "Amount (\$)"),
                  InputWidget(
                    hint: "Enter Amount",
                    controller: amountController,
                    keyboardType: TextInputType.number,
                  ),

                  // ==============================================================
                  // Text("Category", style: sectionTitleStyle),
                  sectionHeader(title: "Category"),
                  DropDownWidget(
                    selectedDrop: selectedCategory,
                    hintText: "Select Category",
                    dropdownList: categoryDropdown,
                    onChanged: (val) {
                      setState(() {
                        selectedCategory = val;
                      });
                    },
                  ),
                  // =================================================================
                  sectionHeader(title: "Description"),

                  // Text("Description", style: sectionTitleStyle),
                  InputWidget(
                    hint: "What was this for?",
                    controller: descController,
                    keyboardType: TextInputType.text,
                  ),

                  // =========================================================================

                  // ==========================================================================
                  // DATE PICKER
                  // ==========================================================================
                  sectionHeader(title: "Date"),

                  // Text("Date", style: sectionTitleStyle),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        // initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCDBDB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          selectedDate == null
                              ? "Select Date"
                              : DateFormat(
                                  "dd MMMM yyyy",
                                ).format(selectedDate!),

                          // : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // =================================================================================
                  // ACTION BUTTON
                  // =================================================================================
                  ActionButton(
                    onPress: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ExpenseApp()),
                      // );
                      if (amountController.text.isEmpty || selectedType == null) return;
                      setState(() {
                        manager.transactions.add(
                          Transaction(
                            amount: double.tryParse(amountController.text) ?? 0,
                            type: selectedType?.toLowerCase().trim() ?? '',
                            category: selectedCategory ?? '',
                            description: descController.text,
                            date: selectedDate ?? DateTime.now(),
                          ),
                        );
                        // Optionally clear fields after adding
                        amountController.clear();
                        descController.clear();
                        selectedType = null;
                        selectedCategory = null;
                        selectedDate = null;
                      });
                    },
                  ),
                  // ==============================================================================
                ],
              ),
            // ==================================================================================
            // HISTORY SECTION
            // =================================================================================
            if (selectedTab == 2)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: double.infinity,
                      // height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "This Month",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Income:"),
                                Text("₦${manager.totalIncome.toStringAsFixed(2)}", style: inwardTextStyle),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Expenses:"),
                                Text("₦${manager.totalExpense.toStringAsFixed(2)}", style: outwardTextStyle),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Net:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("₦${manager.balance.toStringAsFixed(2)}", style: inwardTextStyle),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ...manager.transactions.map((val) {
                    return HistoryContainer(transaction: val);
                  }),
                ],
              ),
            // ==================================================================================
          ],
        ),
      ),
    );
  }

  // ==============================================================================================
  Padding sectionHeader({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(title.toUpperCase(), style: sectionTitleStyle),
    );
  }
  // ============================================================================================

  // ========================================================================================
  //=========================================================================================
  Row contaninerIncomeText({
    required String title1,
    required String amount1,
    required String title2,
    required String amount2,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(title1, style: TextStyle(color: Colors.white)),
            Text(
              amount1,
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // =====================================================================
        Column(
          children: [
            Text(title2, style: TextStyle(color: Colors.white)),
            Text(
              amount2,
              style: TextStyle(
                color: Colors.red[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // MY Calculate totals
  // double get totalIncome => transactions
  //     .where((tx) => tx["type"] == "income")
  //     .fold(0.0, (sum, tx) => sum + tx["amount"]);

  // double get totalExpense => transactions
  //     .where((tx) => tx["type"] == "expense")
  //     .fold(0.0, (sum, tx) => sum + tx["amount"]);

  // double get totalLoan => transactions
  //     .where((tx) => tx["type"] == "loan")
  //     .fold(0.0, (sum, tx) => sum + tx["amount"]);

  // double get totalLoanRepayment => transactions
  //   .where((tx) => tx.type == "loanRepayment")
  //   .fold(0.0, (sum, tx) => sum + tx.amount);

  // double get outstandingLoan => totalLoan - totalLoanRepayment;

  // double get balance => (totalIncome + totalLoan) - (totalExpense + totalLoanRepayment);

  // double get balance => totalIncome - totalExpense;

  // =================================================================================
  // DATE PICKER
  // =================================================================================
  // Remove or refactor this function to avoid non-constant default values.
  // If you need a date picker, define a method and pass DateTime.now() at call time.
  // Example:
  // Future<void> showDatePickerDialog(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime.now(),
  //   );
  // Handle picked date here
  // }
}
