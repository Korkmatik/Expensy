import 'package:expense_planer/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_planer/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _transactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final weekDayIdentifier = DateFormat.E().format(weekDay);

      // Calculating the amount on the given weekday
      double totalAmount = 0.0;
      for (var i = 0; i < _transactions.length; i++) {
        if (_transactions[i].date.day == weekDay.day &&
            _transactions[i].date.month == weekDay.month &&
            _transactions[i].date.year == weekDay.year) {

          totalAmount += _transactions[i].amount;
        }
      }

      return {'day': weekDayIdentifier, 'amount': totalAmount};
    });
  }

  double get maxSpending {
    double spending = groupedTransactionValues.fold(0.0, (previousValue, element) => previousValue + (element['amount'] as double));
    return spending > 0 ? spending : 1;
  }

  const Chart(this._transactions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            String day = (data['day'] as String);
            double amount = (data['amount'] as double);
            return Flexible(fit: FlexFit.tight, child: ChartBar(day, amount, amount / maxSpending));
          }).toList(),
        ),
      ),
    );
  }
}
