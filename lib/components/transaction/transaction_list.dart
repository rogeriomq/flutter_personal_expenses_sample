import 'package:flutter/material.dart';
import 'package:personal_expenses/components/transaction/transaction_list_item_stateless.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  const TransactionList({
    Key? key,
    required this.transactions,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (_, constraints) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Nenhuma transação cadastrada',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * .6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final currentTransaction = transactions[index];
              debugPrint(currentTransaction.id);
              // TIPS::: With StateFul, use GlobalObjectKey for sync state(Bug with ValueKey)
              // return TransactionListItemStateFul(
              //   key: GlobalObjectKey(currentTransaction),
              //   currentTransaction: currentTransaction,
              //   onRemove: onRemove,
              // );

              return TransactionListItemStateless(
                currentTransaction: currentTransaction,
                onRemove: onRemove,
              );
            },
          );
  }
}
