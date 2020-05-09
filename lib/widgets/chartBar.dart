import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double amountSpent;
  final double percentOfTotalAmount;
  final String label;

  ChartBar({this.label, this.amountSpent, this.percentOfTotalAmount});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      // this is a widget that gives information about the parent widget that these things are wrapped in, like height and width.
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            child:Text('\$${amountSpent.toStringAsFixed(0)}', style: TextStyle(fontSize: 20),), 
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 14,
            height: constraints.maxHeight *
                0.7, // so we can use the contraints argument that flutter provides to calculate sizes of the widget related to the parent widget and not the mobile screen.
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
          Container(
            height: constraints.maxHeight * 0.15,
            child:Text(label),
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
          ),
        ],
      );
    });
  }
}
