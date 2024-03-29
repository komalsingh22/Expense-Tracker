import 'package:expense_tracker/charts/chart.dart';
import 'package:expense_tracker/screen/bottomsheet.dart';
import 'package:expense_tracker/widget/expenselist.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Expense> _registered = [
    Expense(
        name: 'EK Tha Tiger',
        amount: 45,
        date: DateTime.now(),
        category: Category.lesiure),
    Expense(
        name: 'Course',
        amount: 56,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        name: 'Burger',
        amount: 24,
        date: DateTime.now(),
        category: Category.food)
  ];

  void _pressaddIcons() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => BottomSheets(
              onAddexpenses: _addExpense,
            ));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registered.add(expense);
    });
  }

  void _removeexpense(Expense expense) {
    final index = _registered.indexOf(expense);
    setState(() {
      _registered.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registered.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? mainContent;
    if (_registered.isNotEmpty) {
      mainContent = ExpenseList(
        listExpense: _registered,
        wantToRemove: _removeexpense,
      );
    } else {
      mainContent = const Center(
        child: Text('No Expense Found.start adding some!'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(onPressed: _pressaddIcons, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registered),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
