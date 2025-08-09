import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:expense_tracker_app/widgets/expense_card.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final Function(ExpenseModel) onRemoveExpense;
  final List<ExpenseModel> registeredExpenses;

  const ExpensesList({
    required this.onRemoveExpense,
    this.registeredExpenses = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: registeredExpenses.length,
      itemBuilder: (context, index) {
        ExpenseModel item = registeredExpenses[index];

        return Dismissible(
          key: Key(item.id),

          background: Container(
            color: Theme.of(context).colorScheme.error,
            margin: Theme.of(context).cardTheme.margin,
          ),
          onDismissed: (direction) {
            onRemoveExpense(item);
          },
          child: ExpenseCard(expenseModel: item),
        );
      },
    );
  }
}
