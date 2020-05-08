import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xpense/models/transactionModel.dart';
import 'package:intl/intl.dart';
import 'package:xpense/widgets/chartBar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactionList;
  Chart(this.recentTransactionList);

  List<Map<String, Object>> get getDetailForDay {
    // we are calling a getter function that returns a list of maps.
    return List.generate(7, (index) {
      // this function generates a list of 7 items
      var weekDay = DateTime.now().subtract(
        //this subtracts the number of days from now, and till past seven days.
        Duration(days: index),
      );
      double totalsum = 0.0;

      for (var i = 0; i < recentTransactionList.length; i++) {
        //this loop calculates the total sum of money spent for the given day.
        if (recentTransactionList[i].date.day == weekDay.day &&
            recentTransactionList[i].date.month == weekDay.month &&
            recentTransactionList[i].date.year == weekDay.year) {
          totalsum += recentTransactionList[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0,
            2), // this function gives days as in words, the first two letters to be precise.
        'amount': totalsum.toString()
      };
    });
  }

  double get getWeekAmountTotal {
    // a getter function to get the total amount spent on that week
    return getDetailForDay.fold(0.0, (previousValue, element) {
      return double.parse(element['amount']) + previousValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(getDetailForDay);
    return Container(
      margin: EdgeInsets.all(20),
      child: Card(
        elevation: 6,
        child: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: getDetailForDay.map((tx) {
                return ChartBar(
                  label: tx['day'],
                  amountSpent: double.parse(tx['amount']),
                  percentOfTotalAmount: (getWeekAmountTotal == 0)
                      ? 0.0
                      : double.parse(tx['amount']) / getWeekAmountTotal,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
