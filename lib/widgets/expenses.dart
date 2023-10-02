import 'package:expense_tracker3/widgets/chart/chart.dart';
import 'package:expense_tracker3/widgets/expenseslist/expenses_list.dart';
import 'package:expense_tracker3/models/expense.dart';
import 'package:expense_tracker3/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpenses = [
    Expense(
        title: 'Futter list',
        amount: 20.2,
        category: Category.food,
        date: DateTime.now(),
        description: 'this is List '),
    Expense(
        title: 'work list',
        amount: 20.2,
        category: Category.work,
        date: DateTime.now(),
        description: 'this is List '),
  ];

  void _openAddExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addNewExpense),
    );
  }

  void _addNewExpense(Expense expense) {
    setState(() {
      _registerExpenses.add(expense);
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
        duration: Duration(
          seconds: 3,
        ),
        content: Text('you removed this List'),
        action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              setState(() {
                _registerExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(context) {
    Widget mainScren = Center(
      child: Text('This Screen Is empty'),
    );
    if (_registerExpenses.isNotEmpty) {
      mainScren = ExpensesList(
        expenses: _registerExpenses,
        onRemove: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Traker'),
        actions: [
          IconButton(
            onPressed: _openAddExpense,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registerExpenses),
          Expanded(child: mainScren),
        ],
      ),
    );
  }
}
