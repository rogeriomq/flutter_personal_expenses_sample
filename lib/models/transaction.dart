// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });

  String getCurrency() {
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt-br');
    return formatter.format(value);
  }
}
