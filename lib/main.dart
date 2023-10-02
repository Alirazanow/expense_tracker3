import 'package:expense_tracker3/widgets/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color.fromARGB(255, 238, 238, 238)),
      home: Expenses(),
    ),
  );
}
