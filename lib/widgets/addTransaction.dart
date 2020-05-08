import 'package:flutter/material.dart';
import 'package:xpense/transactionList.dart';
import 'package:date_format/date_format.dart';

class AddTransaction extends StatefulWidget {
  final Function addTrans;
  AddTransaction(this.addTrans);
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  String titleInput;
  String amountInput;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;
  void _chooseDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      // Date picker returns Future date that has been chosen, by the user after the user click ok on the date picker
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10),
          child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    style: TextStyle(
                      color: Color(0xff410056),
                    ),
                    decoration: InputDecoration(
                      labelText: "Title",
                    ),
                    onChanged: (title) {
                      //This saves the value with every keystroke change into the variable titleInput.
                      titleInput = title;
                    },
                    controller: titleController,
                  ),
                  TextField(
                    keyboardType: TextInputType
                        .number, // this is keyboard type, like only numeric keyboard should appear
                    style: TextStyle(
                      // when entering amount.
                      color: Color(0xff410056),
                    ),
                    decoration: InputDecoration(
                      labelText: "Amount",
                    ),
                    onChanged: (amount) {
                      amountInput = amount;
                    },
                    controller:
                        amountController, //Alternative to the onChanged function, it listen to the user input and auotmatically saves them.
                  ),
                  Row(children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        (selectedDate == null)?'No Date Choosen !':formatDate(selectedDate,[M, '/', dd, '/', yyyy]),
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff410056),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                        onPressed: _chooseDate,
                        child: Icon(
                          Icons.calendar_today,
                          color: Color(0xff410056),
                        ),
                      ),
                    )
                  ]),
                  RaisedButton(
                    onPressed: () {
                      widget.addTrans(
                          titleController.text,
                          double.parse(amountController
                              .text), selectedDate); // here we are passing the data to the pointed function.

                      print(
                          transactionsList); // double.parse takes a string a convert a string into a double
                    },
                    color: Color(0xff410056),
                    child: Text(
                      'Add Transaction',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
