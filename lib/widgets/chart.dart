import 'package:flutter/material.dart';
import 'package:flutterexpenseappudemy/widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  List<Map<String, Object>> get recentTransactionWeekDay {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmountSpend = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmountSpend += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalAmountSpend);
      return {
        'day': DateFormat.E().format(weekDay).substring(0,1),
        'amount': totalAmountSpend
      };
    }).reversed.toList();
  }

  get totalSpending {
    return recentTransactionWeekDay.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20.0),
      elevation: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: recentTransactionWeekDay.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ChartBar(
                  data['day'],
                  data['amount'],
                 totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
                ),
              ),
            );
          }).toList(),
      ),
    );
  }
}
