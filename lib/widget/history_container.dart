import 'package:flutter/material.dart';
import 'package:finora/constant.dart';
import 'package:finora/model/transaction.dart';

// import 'package:intl/intl.dart';

class HistoryContainer extends StatelessWidget {
  const HistoryContainer({required this.transaction, super.key});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        // height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: const Color(0xFFE0E0E0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    transaction.category.toString().toUpperCase(),
                    style: TextStyle(fontSize: 12),
                  ),
                  // GestureDetector(child: Icon(Icons.cancel, color: Colors.red)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(transaction.description.toString()),
                  Text(
                    "${transaction.type == "expense" || transaction.type == "loan" ? "-" : "+"}₦${transaction.amount.toStringAsFixed(2)}",
                    style: TextStyle(
                      color:
                          transaction.type == "expense" ||
                              transaction.type == "loan"
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
                // DateFormat("dd MMMM yyyy").format(transaction.date),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
