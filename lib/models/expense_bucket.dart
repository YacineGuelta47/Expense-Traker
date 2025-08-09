import 'package:expense_tracker_app/models/expense_model.dart';

class ExpenseBucket {
  Category category;
  List<ExpenseModel> expenses;

  ExpenseBucket({required this.category, required List<ExpenseModel> expenses})
    : expenses = expenses.where((item) => category == item.category).toList();

  double get total {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
