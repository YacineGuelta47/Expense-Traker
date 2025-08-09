import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Category { travel, work, food, housing, Transportation ,Shopping ,Health , other }

Uuid uuid = Uuid();

Map<Category, IconData> categoryIcons = {
  Category.travel: Icons.flight_rounded,
  Category.work: Icons.work_rounded,
  Category.food: Icons.fastfood_rounded,
  Category.housing: Icons.house,
  Category.Transportation: Icons.emoji_transportation,
  Category.Shopping : Icons.shopping_bag,
  Category.Health  : Icons.health_and_safety,
  Category.other: Icons.menu,
};

DateFormat formatter = DateFormat('dd-MM-yyyy');

class ExpenseModel {
  String id;
  String title;
  double amount;
  DateTime date;
  Category category;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate => formatter.format(date);
}
