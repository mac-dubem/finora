import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:finora/constant.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleSection(title: "data"),
            reuseableSettingsBar(
              child: Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.sun_max_fill, color: Colors.grey[500]),
                  Text(
                    "Dark Mood",
                    style: TextStyle(
                      fontSize: 15,
                      color: myAppTheme.kContainerTextColor,
                    ),
                  ),
                  Spacer(),

                  SizedBox(
                    height: 20,
                    child: Switch(
                      value: myAppTheme.isWhite,
                      onChanged: (val) {
                        setState(() {
                          myAppTheme.setIsWhite =
                              !myAppTheme.isWhite; // change theme when switched
                        });
                        //  await _loadTransactions();
                        print(myAppTheme.isWhite.toString());
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // titleSection(title: "Currency"),
            GestureDetector(
              onTap: () {
                showCurrencyPicker(
                  context: context,
                  onSelect: (Currency currency) {
                    print('Selected currency: ${currency.code}');
                  },
                  // currencyFilter: <String>['EUR', 'GBP', 'USD', 'AUD', 'CAD', 'JPY', 'HKD', 'CHF', 'SEK', 'ILS']
                );
              },
              child: reuseableSettingsBar(
                child: Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.flag, color: Colors.grey[500]),
                    Text(
                      "Select Currency",
                      style: TextStyle(
                        fontSize: 15,
                        color: myAppTheme.kContainerTextColor,
                      ),
                    ),
                    Spacer(),
                    Icon(CupertinoIcons.right_chevron, size: 16),
                  ],
                ),
              ),
            ),

            titleSection(title: "About"),
            reuseableSettingsBar(
              child: Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.info_circle, color: Colors.grey[500]),
                  Text(
                    "App Version",
                    style: TextStyle(
                      fontSize: 15,
                      color: myAppTheme.kContainerTextColor,
                    ),
                  ),
                  Spacer(),

                  Text(
                    "1.0.0",
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================================
  // ===========================================================================================
  Padding titleSection({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[600]),
      ),
    );
  }

  // ===========================================================================================
  // ===========================================================================================
  Container reuseableSettingsBar({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(15),
      // height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
        color: myAppTheme.kContainerColor,
        // color: Colors.grey[100],
      ),

      child: child,
    );
  }
}
