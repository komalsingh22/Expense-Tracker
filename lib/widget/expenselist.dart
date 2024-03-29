
import 'package:expense_tracker/widget/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.listExpense, required this.wantToRemove});

  final List<Expense> listExpense;
  final void Function(Expense expense) wantToRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listExpense.length,
      itemBuilder: (context, index) =>
           Dismissible(
            key: ValueKey(listExpense[index]),
            background: Container(
              margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              
              color: Theme.of(context).colorScheme.error.withOpacity(0.5),
            ),
            onDismissed: (direction) {
              wantToRemove(listExpense[index]);
            },
            child: ExpenseItem(listExpense[index])),
    );
  }
}
