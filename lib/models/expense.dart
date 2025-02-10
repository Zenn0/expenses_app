import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat('dd/MM/yyyy');

const uuid = Uuid();

enum ExpenseType {
  income,
  expense,
  food,
  travel,
  shopping,
}

const categoryIcons = {
  ExpenseType.income: Icons.attach_money,
  ExpenseType.expense: Icons.money_off,
  ExpenseType.food: Icons.shopping_cart,
  ExpenseType.travel: Icons.flight,
  ExpenseType.shopping: Icons.shopping_bag,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.type})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseType type;

  get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> expenses, this.category)
      : expenses = expenses.where((expense) => expense.type == category).toList();

  final ExpenseType category;
  final List<Expense> expenses;

  double get totalAmount {
    double total = 0.0;
    for (var expense in expenses) {
      total += expense.amount;
    }
    return total;
  }
}
