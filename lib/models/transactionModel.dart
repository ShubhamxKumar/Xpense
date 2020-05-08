import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date; // pre build class in dart to display date and time.

  Transaction(
      {
        @required this.id,
      @required this.title,
      @required this.amount,
      @required this.date}); //wrapping the variables means that they are named arguments.
}
