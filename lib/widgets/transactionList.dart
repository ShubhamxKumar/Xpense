import 'package:flutter/material.dart';
import 'package:xpense/widgets/transactionCard.dart';

import '../transactionList.dart';

class TransactionList extends StatefulWidget {
  final Function deleteTrans;
  TransactionList(this.deleteTrans);
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  void deleteTransactions(String id) {
    setState(() {
      transactionsList.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            deleteTransaction: widget.deleteTrans,
          );
        },
        itemCount: transactionsList.length,
      ),
    );
  }
}
