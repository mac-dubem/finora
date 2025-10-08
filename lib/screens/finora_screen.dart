import 'package:finora/services/datebase_service.dart';
import 'package:flutter/material.dart';
import 'package:finora/constant.dart';
import 'package:finora/model/manager.dart';
// import 'package:finora/model/sheet.dart' ;
import 'package:finora/model/transaction.dart';
import 'package:finora/screens/setting.dart';
import 'package:finora/widget/action_button.dart';
import 'package:finora/widget/dropdown_widget.dart';
import 'package:finora/widget/history_container.dart';
import 'package:finora/widget/input_widget.dart';
import 'package:finora/widget/outward_container_widget.dart';
// import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';

class FinoraScreen extends StatefulWidget {
  const FinoraScreen({super.key});

  @override
  State<FinoraScreen> createState() => _FinoraScreenState();
}

class _FinoraScreenState extends State<FinoraScreen> {
  // ================== APP TAB BAR =====================================
  int selectedTab = 0;
  List<String> appTab = ["Add Transaction", "Loan", "History"];
  // ====================================================================

  // ====================================================================
  final TransactionManager manager = TransactionManager();
  // final List<Map<String, dynamic>> transactions = [];
  // final List<TransactionModel> transactions = [];

  final descController = TextEditingController();
  final amountController = TextEditingController();
  String? selectedType;
  String? selectedCategory;
  DateTime? selectedDate;
  // ===========================================================================

  // ================== DATABASE SERVER =========================================
  final DBService dbService = DBService.instance;

  @override
  void initState() {
    super.initState();

    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    await manager.loadTransactions();
    setState(() {});
  }
  // ==============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Expense Tracker",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingPage()),
              );
            },
          ),
        ],
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
                color: const Color(0xFF192C6C),
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
                      "₦${manager.balance.toStringAsFixed(2)}",
                      // "\$146,500.00",
                      // "₦${balance.toStringAsFixed(2)"}
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),

                    contaninerIncomeText(
                      title1: "Income",
                      amount1: "₦${manager.totalIncome.toStringAsFixed(2)}",

                      title2: "Expenses",
                      amount2: "₦${manager.totalExpense.toStringAsFixed(2)}",
                    ),
                    contaninerIncomeText(
                      title1: "Loans Paid",
                      amount1:
                          " ₦${manager.totalLoanRepayment.toStringAsFixed(2)}",
                      title2: "Loans Owed",
                      amount2: " ₦${manager.totalLoan.toStringAsFixed(2)}",
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
                    dropdownList: ["Expense", "Income ", "Loan", "Repayment"],
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
                    dropdownList: [
                      "Foods & Dining",
                      "Transportation",
                      "Shopping",
                      "Bills & Utilities",
                      "Entertainment",
                      "Health & Medical",
                      "Other",
                    ],
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
                    onPress: () async {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ExpenseApp()),
                      // );
                      if (amountController.text.isEmpty ||
                          selectedType == null ||
                          selectedCategory == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.white,
                            content: Text("Please fill all fields",style: TextStyle(color: Colors.red),),
                          ),
                        );
                        return;
                      }
                      final newTransaction = TransactionModel(
                        category: selectedCategory ?? '',
                        description: descController.text,
                        amount: double.tryParse(amountController.text) ?? 0,
                        type: selectedType?.toLowerCase().trim() ?? '',
                        date: selectedDate ?? DateTime.now(),
                      );

                      await manager.addTransaction(newTransaction);
                      await _loadTransactions();
                      // Optionally clear fields after adding
                      amountController.clear();
                      descController.clear();
                      selectedType = null;
                      selectedCategory = null;
                      selectedDate = null;
                    },
                  ),
                  // ==============================================================================
                ],
              ),
            // =================================================================================
            // LOAN SECTION
            // ================================================================================
            if (selectedTab == 1)
              Column(
                children: [
                  InOutwardContainter(
                    manager: manager,
                    inwardTitle: "Loan Repayment",
                    outwardTitle: "Loan Owed",
                    inwardAmount:
                        " ₦${manager.totalLoanRepayment.toStringAsFixed(2)}",
                    outwardAmount: " ₦${manager.totalLoan.toStringAsFixed(2)}",
                    balanceAmount:
                        "₦${manager.outstandingLoan.toStringAsFixed(2)}",
                  ),
                  ...manager.transactions
                      .where(
                        (val) => val.type == "loan" || val.type == "repayment",
                      )
                      .map((val) {
                        return HistoryContainer(transaction: val);
                      }),
                ],
              ),

            // ================================================================================
            // ==================================================================================
            // HISTORY SECTION
            // =================================================================================
            if (selectedTab == 2)
              Column(
                children: [
                  InOutwardContainter(
                    manager: manager,
                    inwardTitle: "Income:",
                    outwardTitle: "Expense:",
                    inwardAmount: "₦${manager.totalIncome.toStringAsFixed(2)}",
                    outwardAmount:
                        "₦${manager.totalExpense.toStringAsFixed(2)}",
                    balanceAmount: "₦${manager.balance.toStringAsFixed(2)}",
                  ),
                  ...manager.transactions
                      .where(
                        (val) => val.type == "income" || val.type == "expense",
                      )
                      .map((val) {
                        return HistoryContainer(transaction: val);
                      }),
                ],
              ),
            // =============================================================================
          ],
        ),
      ),
    );
  }

  // ========================= Helper for section headers ==================================
  Padding sectionHeader({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(title.toUpperCase(), style: sectionTitleStyle),
    );
  }
  // ========================================================================================

  // ========================================================================================
  // HELPS FOR THE INCOME AND EXPENSES CONTAINER ROW
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
            Text(
              title1,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Text(
              amount1,
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // ===================================================================================
        Column(
          children: [
            Text(
              title2,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
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
  // =============================================================================================

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
