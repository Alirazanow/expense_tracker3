import 'package:expense_tracker3/models/expense.dart';
import 'package:expense_tracker3/widgets/expenseslist/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemove});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemove;

  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
              color: Color.fromARGB(255, 255, 0, 0),
            ),
            onDismissed: (direction) {
              onRemove(expenses[index]);
            },
            child: ExpensesItem(expenses[index])));
  }
}
