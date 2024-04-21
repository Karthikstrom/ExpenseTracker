// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_data.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(ExpenseData expense)
      onAddExpense; // here onAddExpense is a property and - Function is the data type

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _SelectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController
        .dispose(); //telling flutter to close of the memory usage if not will eventually lead the app to crash
    _amountController.dispose();
    super.dispose();
  }

  //Here we are validating the input fields
  void _submitExpenseData() {
    final enteredAmount =
        double.tryParse(_amountController.text); //String to double if not null
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _SelectedDate == null) //we need to check all the fields and not just
    {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was enetered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('Okay'))
          ],
        ),
      );
      return; //show error message
    } else {
      widget.onAddExpense(ExpenseData(
          title: _titleController.text,
          amount: enteredAmount,
          date: _SelectedDate!,
          category: _selectedCategory));
    }

    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _SelectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
            child: Column(children: [
              if (width >= 600)
                Row(children: [
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: InputDecoration(label: Text('Title')),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                      decoration: InputDecoration(
                        prefixText: '\$ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                ])
              else
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: InputDecoration(label: Text('Title')),
                ),
              SizedBox(height: 10),
              if (width >= 600)
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value:
                                      category, //user selection//here category is arbitary- sort of like I in iterable
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == null) {
                                return; // if we return in a function, no code will further be executed
                              }
                              _selectedCategory = value;
                            });
                          }),
                      const SizedBox(width: 10),
                      Text(_SelectedDate == null
                          ? 'No Selected Date'
                          : formatter.format(_SelectedDate!)),
                      IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month)),
                    ])
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                        decoration: InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 60),
                    Row(
                      children: [
                        Text(_SelectedDate == null
                            ? 'No Selected Date'
                            : formatter.format(_SelectedDate!)),
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month)),
                      ],
                    ),
                  ],
                ),
              if(width>=600)
                Row(children: [ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text('Submit')),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel')),],)
              else 
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value:
                                  category, //user selection//here category is arbitary- sort of like I in iterable
                              child: Text(category.name.toUpperCase()),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return; // if we return in a function, no code will further be executed
                          }
                          _selectedCategory = value;
                        });
                      }), //value choosen from the dropdown which is dynamic
                  SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text('Submit')),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel')),
                ],
              ),
            ]),
          ),
        ),
      );
    });
  }
}
