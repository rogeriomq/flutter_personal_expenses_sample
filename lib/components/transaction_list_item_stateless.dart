import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionListItemStateless extends StatelessWidget {
  final Transaction currentTransaction;
  final void Function(String p1) onRemove;
  final Color? backgroundColor;

  const TransactionListItemStateless({
    Key? key,
    required this.currentTransaction,
    required this.onRemove,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(child: Text(currentTransaction.getCurrency())),
          ),
        ),
        title: Text(
          currentTransaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(currentTransaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () => onRemove(currentTransaction.id),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style:
                    TextButton.styleFrom(primary: Theme.of(context).errorColor),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => onRemove(currentTransaction.id),
              ),
      ),
    );
  }
}
