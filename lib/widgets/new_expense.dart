import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  final Function(ExpenseModel) onAddExpense;

  const NewExpense({required this.onAddExpense, super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  DateTime? selectedDate = DateTime.now();

  Category selectedCategory = Category.other;

  void openDatePickerDialog() async {
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2030);

    showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((value) {
      setState(() {
        selectedDate = value;
      });
    });
  }

  void saveExpense() {
    double? amount = double.tryParse(amountController.text);

    if (titleController.text.isEmpty ||
        amount == null ||
        amount <= 0 ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    } else {
      ExpenseModel expense = ExpenseModel(
        title: titleController.text,
        amount: amount,
        date: selectedDate!,
        category: selectedCategory,
      );

      widget.onAddExpense(expense);

      // close the bottom sheet
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    print('keyboardHeight = $keyboardHeight');
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 15, keyboardHeight),
      child: SingleChildScrollView(
        child: Column(
          spacing: 15,
          children: [
            TextField(
              controller: titleController,
              maxLength: 40,
              decoration: InputDecoration(label: Text('Title')),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: amountController,
                    decoration: InputDecoration(
                      label: Text('Amount'),
                      prefix: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text('DZD', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        selectedDate == null
                            ? 'No Date Selected'
                            : formatter.format(selectedDate!),
                      ),
                      IconButton(
                        onPressed: openDatePickerDialog,
                        icon: Icon(Icons.calendar_month_rounded),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                DropdownButton(
                  value: selectedCategory,
                  items: Category.values
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  onPressed: saveExpense,
                  child: Text('Save Expense'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
  }
}
