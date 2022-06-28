// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function({
    required String title,
    required double value,
    DateTime? date,
  }) onAddTransaction;

  const TransactionForm({Key? key, required this.onAddTransaction})
      : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _dateSelected;

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;
    if (title.isEmpty || value <= 0) {
      debugPrint('Deu ruim...');
      return;
    }

    widget.onAddTransaction(title: title, value: value, date: _dateSelected);
  }

  _showDatePicker() async {
    DateTime? result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (result != null) {
      setState(() {
        _dateSelected = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Add/Edit Expense',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Colors.purple,
                ),
                focusColor: Colors.purpleAccent,
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Value(R\$)',
                labelStyle: TextStyle(
                  color: Colors.purple,
                ),
              ),
              onSubmitted: (_) => _submitForm(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(_dateSelected == null
                      ? 'No date selected!'
                      : 'Selected date: ${DateFormat('dd/MM/y').format(_dateSelected as DateTime)}'),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: const Text(
                    'Select Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => _submitForm(),
                  child: const Text(
                    'Add Transaction',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
