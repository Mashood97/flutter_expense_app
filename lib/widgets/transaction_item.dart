import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: FittedBox(
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Text('\$${transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat().add_yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
          onPressed: () => deleteTx(transaction.id),
          icon: const Icon(Icons.delete),
          label: const Text('Delete'),
          textColor: Theme.of(context).errorColor,
        )
            : IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => deleteTx(transaction.id),
        ),
      ),
    );
  }
}
