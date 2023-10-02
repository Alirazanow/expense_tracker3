import 'package:expense_tracker3/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titeControlller = TextEditingController();
  final _desControlller = TextEditingController();
  final _amountControlller = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _datePiker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submittingData() {
    final enterAmount = double.tryParse(_amountControlller.text);
    final ammountInvalid = enterAmount == null || enterAmount <= 0;
    if (_titeControlller.text.isEmpty ||
        ammountInvalid ||
        _selectedDate == null) {
      // error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid'),
          content: Text('Field Is empty'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('okay'))
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titeControlller.text,
          description: _titeControlller.text,
          amount: enterAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _desControlller.dispose();
    _titeControlller.dispose();
    _amountControlller.dispose();

    super.dispose();
  }

  // var _enterTitle = '';
  // var _enterDescription = '';

  // void _saveTitleInput(String inputValue) {
  //   _enterTitle = inputValue;
  // }

  // void _saveDesInput(String inputValue) {
  //   _enterDescription = inputValue;
  // }

  @override
  Widget build(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        60,
        16,
        16,
      ),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titeControlller,
            decoration: const InputDecoration(label: Text('Yor Expanse Title')),
          ),
          TextField(
            maxLength: 80,
            controller: _desControlller,
            decoration: const InputDecoration(label: Text('Describe')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountControlller,
                  decoration: const InputDecoration(
                      prefixText: '\$ ', label: Text('Amount')),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No date selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _datePiker,
                      icon: Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (Category) => DropdownMenuItem(
                        value: Category,
                        child: Text(
                          Category.name.toLowerCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancle')),
              ElevatedButton(onPressed: _submittingData, child: Text('Save'))
            ],
          ),
        ],
      ),
    );
  }
}
