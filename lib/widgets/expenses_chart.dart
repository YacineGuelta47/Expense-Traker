import 'package:expense_tracker_app/models/expense_bucket.dart';
import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:expense_tracker_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

class ExpensesChart extends StatelessWidget {
  final List<ExpenseModel> expenses;

  const ExpensesChart({required this.expenses, super.key});

  List<ExpenseBucket> get buckets => Category.values
      .map((category) => ExpenseBucket(category: category, expenses: expenses))
      .toList();

  @override
  Widget build(BuildContext context) {
    double totalAmount = 0;

    for (var expense in expenses) {
      totalAmount = totalAmount + expense.amount;
    }

    return Container(
      width: double.infinity,
      height: 180,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        spacing: 10,
        children: [
          for (var bucket in buckets)
            Expanded(
              child: ChartBar(
                category: bucket.category,
                heightFactor:
                    bucket.total / (totalAmount == 0 ? 1 : totalAmount),
              ),
            ),
        ],
      ),
    );
  }
}
