import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:xpense/models/transactionModel.dart';
import 'package:xpense/widgets/addTransaction.dart';
import 'package:xpense/widgets/chart.dart';
import 'package:xpense/widgets/transactionCard.dart';
import 'package:xpense/widgets/transactionList.dart';
import '../transactionList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double sum;

  void deleteTransactions(String id) {
    setState(() {
      transactionsList.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void dataValidation(String title, double amount, DateTime chosenDate) {
    if (title.isNotEmpty && amount >= 0 && chosenDate != null) {
      addTransaction(title, amount, chosenDate);
      Navigator.of(context)
          .pop(); // so that the bottom sheet automatically closes when user taps on the add transaction button.
    }
  }

  void addTransaction(String newTitle, double newAmount, DateTime chosenDate) {
    final newTrans = Transaction(
      title: newTitle,
      amount: newAmount,
      date: chosenDate,
      id: 'item' + transactionsList.length.toString(),
    );
    sum = 0;

    setState(() {
      transactionsList.add(newTrans);
    });

    print(transactionsList.length);
  }

  void startAddNewTransaction(BuildContext ctx) {
    // We are accepting this argument, so that we can pass down to the widget used inside.
    showModalBottomSheet(
        context:
            ctx, // this widget need context as a argument. That's why we use "ctx"
        builder: (s) {
          //this widget accept a function as a parameter. And the builder argument needs
           // a function which accepts a string value, but we don't use it right now,
           //so we just assign a random string.
          return AddTransaction(
              dataValidation); 
        });
  }

  List<Transaction> get recentTransactionList {
    // this getter returns a list
    return transactionsList.where((txn) {
      // which has items only from past 7 days.
      return txn.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList(); // we have to call toList() on where to convert it into a list.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.grey[50],
        title: Center(
          child: Text(
            'Xpense',
            style: TextStyle(
              color: Color(0xff410056),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Chart(recentTransactionList),
          TransactionList(deleteTransactions),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
