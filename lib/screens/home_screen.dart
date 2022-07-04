import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/components/chart/chart.dart';
import 'package:personal_expenses/components/transaction_form.dart';
import 'package:personal_expenses/components/transaction_list.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _uuid = Uuid();
  final isApplePlatform = (Platform.isIOS || Platform.isMacOS);
  bool _showChart = false;

  final List<Transaction> _transactions = [
    // Transaction(
    //   id: _uuid.v1(),
    //   title: 'Agua',
    //   value: 200,
    //   date: DateTime.now().subtract(const Duration(days: 2)),
    // ),
    // Transaction(
    //   id: _uuid.v1(),
    //   title: 'Energia',
    //   value: 103.22,
    //   date: DateTime.now().subtract(const Duration(days: 1)),
    // ),
    // Transaction(
    //   id: _uuid.v1(),
    //   title: 'Energia',
    //   value: 103.22,
    //   date: DateTime.now().subtract(const Duration(days: 1)),
    // ),
    // Transaction(
    //   id: _uuid.v1(),
    //   title: 'Cartão Nubank',
    //   value: 1570,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: _uuid.v1(),
    //   title: 'Agua',
    //   value: 200,
    //   date: DateTime.now().subtract(const Duration(days: 2)),
    // ),
    // Transaction(
    //   id: _uuid.v1(),
    //   title: 'Energia',
    //   value: 103.22,
    //   date: DateTime.now().subtract(const Duration(days: 1)),
    // ),
    // Transaction(
    //   id: _uuid.v1(),
    //   title: 'Energia',
    //   value: 103.22,
    //   date: DateTime.now().subtract(const Duration(days: 1)),
    // ),
    // Transaction(
    //   id: _uuid.v1(),
    //   title: 'Cartão Nubank',
    //   value: 1570,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  void _addTransaction({
    required String title,
    required double value,
    DateTime? date,
  }) {
    final newTransaction = Transaction(
      id: _uuid.v1(),
      title: title,
      value: value,
      date: date ?? DateTime.now(),
    );

    setState(() {
      debugPrint('Add transaction');
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => TransactionForm(onAddTransaction: _addTransaction),
    );
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return isApplePlatform
        ? GestureDetector(
            onTap: fn,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                icon,
                size: 20,
              ),
            ))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    // Otimizando chamada do mediaQuery
    final mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList =
        isApplePlatform ? CupertinoIcons.arrow_right_arrow_left : Icons.list;
    final chartList = isApplePlatform
        ? CupertinoIcons.arrow_right_arrow_left
        : Icons.show_chart;

    final barActions = [
      // if (isLandscape)
      _getIconButton(_showChart ? iconList : chartList,
          () => setState(() => _showChart = !_showChart)),
      _getIconButton(Icons.add, () => _openTransactionFormModal(context))
    ];
    final appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: barActions,
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? .6 : .2),
                child: Chart(recentTransactions: _recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : .7),
                child: TransactionList(
                  transactions: _transactions,
                  onRemove: _removeTransaction,
                ),
              ),
          ],
        ),
      ),
    );

    return isApplePlatform
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: barActions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: isApplePlatform
                ? const SizedBox()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }
}
