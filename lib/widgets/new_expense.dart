import 'package:expenses_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('dd/MM/yyyy');

class NewExpense extends StatefulWidget {
  const NewExpense({super.key,required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  ExpenseType? _selectedType = ExpenseType.expense;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount == null || enteredAmount <= 0|| _selectedDate == null) {

      showDialog(context: context, builder: (_) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text('Please enter all correct values'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(_);

            },
            child: const Text('Okay'),
          ),
        ],
      ));
      return;
    }
    final newExpense = Expense(
      title: enteredTitle,
      amount: enteredAmount,
      date: _selectedDate!,
      type: _selectedType!,
    );
    widget.onAddExpense(newExpense);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 75, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 20,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    labelText: 'Amount',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No date Selected: '
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          DropdownButton(
            value: _selectedType,
            items: ExpenseType.values
                .map((category) => DropdownMenuItem(
                  value: category,
                      child: Text(
                        category.name.toLowerCase(),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                if (value == null) {
                  return;
                }
                setState(() {
                  _selectedType = value;
                });
              });
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Add Expense'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
