import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_data.dart';





class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final ExpenseData expense;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(expense.title),
          const SizedBox(height: 4),
          Row(children: [
            Text('\$${expense.amount.toStringAsFixed(2)}'),
            const Spacer(), // all the space between the widgets hence pushing the text and icon to two ends
            Row(
              children: [
                Icon(categoryIcons[expense.category]),
                const SizedBox(width: 8),
                Text(expense.formattedDate),
              ],
            ),
          ]),
        ],
      ),
    ));
  }
}