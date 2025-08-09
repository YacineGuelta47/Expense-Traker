import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final ExpenseModel expenseModel;

  const ExpenseCard({required this.expenseModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expenseModel.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'DZD ${expenseModel.amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 10,
              children: [
                Icon(categoryIcons[expenseModel.category]),
                Text(expenseModel.formattedDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
