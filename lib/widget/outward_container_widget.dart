import 'package:finora/constant.dart';
import 'package:finora/model/manager.dart';
import 'package:flutter/material.dart';

class InOutwardContainter extends StatelessWidget {
  const InOutwardContainter({
    super.key,
    required this.manager,
    required this.inwardTitle,
    required this.outwardTitle,
    required this.inwardAmount,
    required this.outwardAmount,
    required this.balanceAmount,
  });

  final TransactionManager manager;
  final String inwardTitle;
  final String outwardTitle;
  final String inwardAmount;
  final String outwardAmount;
  final String balanceAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: myAppTheme.kContainerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "This Month",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: myAppTheme.kContainerTextColor) ,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    inwardTitle, style: TextStyle(color: myAppTheme.kContainerTextColor),
                    // "Income:"
                  ),
                  Text(
                    inwardAmount,
                    // "₦${manager.totalIncome.toStringAsFixed(2)}",
                    style: inwardTextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    outwardTitle,
                    style: TextStyle(color: myAppTheme.kContainerTextColor)
                    // "Expenses:"
                  ),
                  Text(
                    outwardAmount,
                    // "₦${manager.totalExpense.toStringAsFixed(2)}",
                    style: outwardTextStyle,
                  ),
                ],
              ),
              Divider(),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Net:", style: TextStyle(fontWeight: FontWeight.bold, color: myAppTheme.kContainerTextColor)),
                  Text(
                    balanceAmount,
                    // "₦${manager.balance.toStringAsFixed(2)}",
                    style:
                        // manager.totalExpense > manager.totalIncome ||
                        //     manager.totalLoan > manager.totalLoanRepayment
                        // ? outwardTextStyle
                        // : inwardTextStyle,
                         TextStyle(
                      color:
                          // manager.totalExpense >  manager.totalIncome ||
                          //    manager.totalLoan > manager.totalLoanRepayment
                          // ? Colors.red
                          // : Colors.green,
                          myAppTheme.kContainerTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
