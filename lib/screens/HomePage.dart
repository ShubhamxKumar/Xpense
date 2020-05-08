import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:xpense/models/transactionModel.dart';
import 'package:xpense/widgets/addTransaction.dart';
import 'package:xpense/widgets/chart.dart';
import 'package:xpense/widgets/transactionCard.dart';

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
          return AddTransaction(
              // a function which accepts a string value, but we don't use it right now,
              dataValidation); //so we just assign a random string.
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
          Container(
            margin: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height -
                300, // parent height is necessary when using builder method, so that it know after what point it should
            //not render elements.
            child: ListView.builder(
              // ListView builder was used in place of List view because it renders only the items that are onscreen and does not render those which are offscreen.
              itemBuilder: (context, index) {
                //itembuilder calls a function which renders the list, it returns the index as int and it access all the indexes one by one
                return TransactionCard(
                  //till the number specified by item count which in this case is the lenght of the list
                  amount: transactionsList[index]
                      .amount, //this is usefull when u dont know the number of items in the list,
                  title: transactionsList[index]
                      .title, //and also increase performance by not building unnecessary items that
                  id: transactionsList[index].id, //do not appear on the screen.
                  date: transactionsList[index].date,
                  deleteTransaction: deleteTransactions,
                );
              },
              itemCount: transactionsList.length,
            ),
          ),
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
