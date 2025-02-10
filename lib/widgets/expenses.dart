import 'dart:ffi';

import 'package:expenses_app/widgets/chart/chart.dart';
import 'package:expenses_app/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/models/expense.dart';
import 'package:google_fonts/google_fonts.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpenses = [
    Expense(
      title: 'Salary',
      amount: 5000,
      date: DateTime.now(),
      type: ExpenseType.income,
    ),
    Expense(
      title: 'Groceries',
      amount: 500,
      date: DateTime.now(),
      type: ExpenseType.food,
    ),
    Expense(
      title: 'Tickets',
      amount: 250,
      date: DateTime.now(),
      type: ExpenseType.travel,
    ),
    Expense(
      title: 'Shoes',
      amount: 1000,
      date: DateTime.now(),
      type: ExpenseType.shopping,
    ),
    Expense(
      title: 'Rent',
      amount: 2500,
      date: DateTime.now(),
      type: ExpenseType.expense,
    ),
  ];

  void _openNewExpenseForm() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return NewExpense(
          onAddExpense: _addExpense,
        );
      },
    );
  }

  void _addExpense(Expense newExpense) {
    setState(() {
      _registerExpenses.add(newExpense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${expense.title} removed'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registerExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses added yet. Start adding some!'),
    );

    if (_registerExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            onPressed: _openNewExpenseForm,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
         Chart(expenses: _registerExpenses),
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
