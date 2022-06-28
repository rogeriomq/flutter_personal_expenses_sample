import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/components/chart/chart_bar.dart';
import 'package:personal_expenses/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({
    Key? key,
    required this.recentTransactions,
  }) : super(key: key);

  List<Map<String, dynamic>> get groupedTransactions {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        double totalSum = 0.0;

        for (var i = 0; i < recentTransactions.length; i++) {
          bool sameDay = recentTransactions[i].date.day == weekDay.day;
          bool sameMonth = recentTransactions[i].date.month == weekDay.month;
          bool sameYear = recentTransactions[i].date.year == weekDay.year;

          if (sameDay && sameMonth && sameYear) {
            totalSum += recentTransactions[i].value;
          }
        }

        debugPrint('call groupedTransactions');

        return {
          'weekDay': DateFormat.E().format(weekDay)[0],
          'day': DateFormat.d().format(weekDay),
          'value': totalSum,
        };
      },
    ).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, cur) {
      return sum += cur['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: groupedTransactions.map((resume) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: resume['weekDay'],
                  value: resume['value'],
                  percentage: _weekTotalValue == 0
                      ? 0
                      : (resume['value'] as double) / _weekTotalValue),
            );
          }).toList(),
        ),
      ),
    );
  }
}
