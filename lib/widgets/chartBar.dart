import 'package:flutter/material.dart';
import 'dart:math';

class ChartBar extends StatelessWidget {
  double amountSpent;
  double percentOfTotalAmount;
  String label;

  ChartBar({this.label, this.amountSpent, this.percentOfTotalAmount});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          FittedBox(child: Text('\$${amountSpent.toStringAsFixed(0)}')),
          Transform.rotate(
            angle: 0,
            child: Container(
              decoration: BoxDecoration(),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width / 14,
              height: 150,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.amber,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[50],
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentOfTotalAmount,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(label),
        ],
      ),
    );
  }
}
