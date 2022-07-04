import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

/// When use listItem stateFul component, necessary set key with GlobalObjectKey
class TransactionListItemStateFul extends StatefulWidget {
  final Transaction currentTransaction;
  final void Function(String p1) onRemove;

  const TransactionListItemStateFul({
    Key? key,
    required this.currentTransaction,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<TransactionListItemStateFul> createState() =>
      _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItemStateFul> {
  static const colors = [
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.amber,
    Colors.green,
    Colors.grey
  ];

  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    int index = Random().nextInt(6);
    _backgroundColor = colors[index];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child:
                FittedBox(child: Text(widget.currentTransaction.getCurrency())),
          ),
        ),
        title: Text(
          widget.currentTransaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.currentTransaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () => widget.onRemove(widget.currentTransaction.id),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style:
                    TextButton.styleFrom(primary: Theme.of(context).errorColor),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.onRemove(widget.currentTransaction.id),
              ),
      ),
    );
  }
}
