import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_data.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class ExpensesTracker extends StatefulWidget {
  const ExpensesTracker({super.key});
  @override
  State<ExpensesTracker> createState() {
    return _ExpensesTracker();
  }
}

class _ExpensesTracker extends State<ExpensesTracker> {
  //List of type ExpenseData to create data structures of that type
  // list here is a property and only used inside the class so private class _
  final List<ExpenseData> _registeredExpenses = [
    ExpenseData(
        title: 'Flutter',
        amount: 19.33,
        date: DateTime.now(),
        category: Category.travel),
    ExpenseData(
        title: 'Dart',
        amount: 25.00,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  //Modal Overlay
  void _openAddExpenseOverlay() {
    //Model object has a different context
    showModalBottomSheet(
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(ExpenseData expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(ExpenseData expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _registeredExpenses.insert(expenseIndex, expense);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    Widget mainContent = const Center(
      child: Text('No Expenses found, start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
          expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }

    return Scaffold(
      backgroundColor: const HsbColor(210, 1, 98),
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add_circle_sharp))
        ],
        foregroundColor: Colors.white,
        backgroundColor: const HsbColor(131, 36, 35),
      ),
      body: width < 600
          ? Column(
              children: [
                //App bar
                Chart(expenses: _registeredExpenses),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                //App bar
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
