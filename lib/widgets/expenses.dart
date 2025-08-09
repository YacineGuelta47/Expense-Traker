import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:expense_tracker_app/widgets/expenses_chart.dart';
import 'package:expense_tracker_app/widgets/expenses_list.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<ExpenseModel> registeredExpenses = [];

  void openAddExpenseBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: addExpense),
    );
  }

  void addExpense(ExpenseModel expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void removeExpense(ExpenseModel expense) {
    int index = registeredExpenses.indexOf(expense);

    setState(() {
      registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registeredExpenses.insert(index, expense);
            });
          },
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker App'),
        // backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: openAddExpenseBottomSheet,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ExpensesChart(expenses: registeredExpenses),
            Expanded(
              child: registeredExpenses.isNotEmpty
                  ? ExpensesList(
                      registeredExpenses: registeredExpenses,
                      onRemoveExpense: removeExpense,
                    )
                  : Center(child: Text('No Expenses found')),
            ),
          ],
        ),
      ),
    );
  }
}
