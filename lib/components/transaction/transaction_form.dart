// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:personal_expenses/components/adaptive_button.dart';
import 'package:personal_expenses/components/adaptive_date_picker.dart';
import 'package:personal_expenses/components/adaptive_textfield.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
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
              AdaptiveTextField(
                label: 'Title',
                controller: _titleController,
              ),
              AdaptiveTextField(
                label: 'Value(R\$)',
                controller: _valueController,
                inputType: const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
              ),
              const SizedBox(height: 20),
              AdaptiveDatePicker(
                selectedDate: _dateSelected,
                onDateChanged: (newDate) {
                  debugPrint('newDate = $newDate');
                  setState(() {
                    _dateSelected = newDate;
                  });
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AdaptiveButton(
                      label: 'Add Transaction',
                      onPressed: _submitForm,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
