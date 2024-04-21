import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat
    .yMd(); // creates a formatted object which is then used to format dates - utility object

const uuid = Uuid(); //utility obj
//Here this is something for defining the data structure

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class ExpenseData {
  ExpenseData(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  //intializer
  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  final Category category;
  final List<ExpenseData> expenses;

  ExpenseBucket.forCategory(List<ExpenseData> allExpenses, this.category)//utility function that filters out expenses that belongs to a specific category
      : expenses = allExpenses
            .where((expense) => expense.category == category)//where takes a function as a argument
            .toList(); //additional extra constructor funtions

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
