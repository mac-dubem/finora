import 'package:finora/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_picker/currency_picker.dart';

class NewSheetBottomPopup extends StatefulWidget {
  const NewSheetBottomPopup({super.key});

  @override
  State<NewSheetBottomPopup> createState() => _NewSheetBottomPopupState();
}

class _NewSheetBottomPopupState extends State<NewSheetBottomPopup> {
  // =========================================================================
  // =========================================================================
  final TextEditingController titleController = TextEditingController(
    text: 'Untitled Sheet',
  );
  final TextEditingController amountController = TextEditingController();
  String currency = 'NGN';
  bool totalBalance = true;
  bool showCurrency = true;
  bool showTime = true;
  Currency? selectedCurrency;
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: myAppTheme.kBackgroundColor,
        borderRadius: BorderRadiusDirectional.vertical(
          top: Radius.circular(20),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // spacing: 20,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: myAppTheme.kButtonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    "New Sheet",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: myAppTheme.kContainerTextColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, {
                        "title": titleController.text,
                        "currency": selectedCurrency?.symbol ?? '₦',
                        'amount': amountController.text.isEmpty
                            ? '0.00'
                            : amountController.text,
                        'date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
                      });
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(
                        color: myAppTheme.kButtonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ==================== TEXTFIELD AREA ======================================
            Padding(
              padding: const EdgeInsets.only(top: kTitleTopPadding),
              child: Text("TITLE", style: kTItleTextStyle),
            ),
            TextField(
              controller: titleController,
              style: TextStyle(color: myAppTheme.kContainerTextColor),
              decoration: InputDecoration(
                filled: true,
                fillColor: myAppTheme.kContainerColor,

                // TextAlign textAlign = TextAlign.center,
                hintText: "Untited Sheet",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              // style: TextStyle(color: myAppTheme.kContainerTextColor),
            ),
            // ===========================================================================
            // SizedBox(height: 5,),
            // ======================= CURRENCY AREA ====================================
            Padding(
              padding: const EdgeInsets.only(top: kTitleTopPadding),
              child: Text("CURRENCY", style: kTItleTextStyle),
            ),
            GestureDetector(
              onTap: () {
                showCurrencyPicker(
                  context: context,
                  showFlag: true,
                  showCurrencyName: true,
                  showCurrencyCode: true,
                  theme: CurrencyPickerThemeData(
                    backgroundColor: myAppTheme.kBackgroundColor,
                    titleTextStyle: TextStyle(
                      color: myAppTheme.kContainerTextColor,
                    ),
                    subtitleTextStyle: TextStyle(color: Colors.grey[600]),
                    currencySignTextStyle: TextStyle(color: Colors.grey[600]),
                    // favorite: ['USD', 'EUR', 'NGN', 'GBP'],
                    inputDecoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: Icon(Icons.search),
                      fillColor: myAppTheme.kContainerColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  onSelect: (Currency currency) {
                    setState(() {
                      selectedCurrency = currency;
                      debugPrint('Selected currency: ${currency.code}');
                    });
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: myAppTheme.kContainerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCurrency == null
                          ? "Select Currency"
                          : "${selectedCurrency!.symbol}     ${selectedCurrency!.code}        ${selectedCurrency!.name}",
                      style: selectedCurrency == null
                          ? TextStyle(color: myAppTheme.kButtonColor)
                          : TextStyle(color: myAppTheme.kContainerTextColor),
                    ),

                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            // ======================== THE TOGGLES ======================================
            Container(
              decoration: BoxDecoration(
                color: myAppTheme.kContainerColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SwitchListTile(
                value: totalBalance,
                title: Text(
                  "Total Balance",
                  style: TextStyle(color: myAppTheme.kContainerTextColor),
                ),
                // activeColor: myAppTheme.kButtonColor,
                onChanged: (val) {},
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: kTitleTopPadding),
              child: Text("INPUT", style: kTItleTextStyle),
            ),

            Container(
              decoration: BoxDecoration(
                color: myAppTheme.kContainerColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SwitchListTile(
                value: showCurrency,
                title: Text(
                  "Show Currency",
                  style: TextStyle(color: myAppTheme.kContainerTextColor),
                ),
                // activeColor: myAppTheme.kButtonColor,
                onChanged: (val) {},
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: myAppTheme.kContainerColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SwitchListTile(
                value: showTime,
                title: Text(
                  "Show Time",
                  style: TextStyle(color: myAppTheme.kContainerTextColor),
                ),

                onChanged: (val) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
