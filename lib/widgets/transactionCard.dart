import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class TransactionCard extends StatefulWidget {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Function deleteTransaction;
  TransactionCard(
      {this.id, this.amount, this.title, this.date, this.deleteTransaction});
  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 6,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(6),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        widget.amount.toStringAsFixed(
                            2), // this displays data for just two decimal points, and also rounds them up.
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff410056),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.id + ", " + widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ), //widget.variable_name is used to access the variable declared in the above class.
                  Text(formatDate(widget.date, [dd, '/', M, '/', yyyy])),
                ],
              ),
              Center(
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Color(0xff410056),
                  ),
                  onPressed: () {
                    widget.deleteTransaction(widget.id);
                    print(widget.id);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
