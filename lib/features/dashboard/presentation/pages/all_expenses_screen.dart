import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';
import 'package:intl/intl.dart';

import '../../data/models/expense_model.dart';
import '../../presentation/bloc/expense_bloc.dart';
import '../../presentation/bloc/expense_event.dart';
import '../../presentation/bloc/expense_state.dart';

class AllExpensesScreen extends StatefulWidget {
  final List<ExpenseModel> expenses;

  const AllExpensesScreen({
    super.key,
    required this.expenses,
  });

  @override
  State<AllExpensesScreen> createState() => _AllExpensesScreenState();
}

class _AllExpensesScreenState extends State<AllExpensesScreen> {
  late List<ExpenseModel> localExpenses;

  @override
  void initState() {
    super.initState();
    localExpenses = List.from(widget.expenses);
  }

  void deleteLocalExpense(String id) {
    setState(() {
      localExpenses.removeWhere((e) => e.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        if (state is ExpenseDeleteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Expense deleted successfully"),
            ),
          );
        }

        if (state is ExpenseFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },

      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),

        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppPallete.borderColor,
          centerTitle: true,
          title: const Text(
            "All Expenses",
            style: TextStyle(
              color: AppPallete.containerColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),

        body: localExpenses.isEmpty
            ? const Center(
          child: Text(
            "No Expenses Found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: localExpenses.length,
          itemBuilder: (context, index) {
            final expense = localExpenses[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 18),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppPallete.backgroundColor,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          expense.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppPallete.textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      IconButton(

                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),

                        onPressed: () async {

                          final bool? confirmDelete = await showDialog(

                            context: context,

                            builder: (context) {

                              return AlertDialog(

                                title: const Text(
                                  "Delete Expense",
                                ),

                                content: const Text(
                                  "Are you sure you want to delete this expense?",
                                ),

                                actions: [

                                  TextButton(

                                    onPressed: () {

                                      Navigator.pop(context, false);
                                    },

                                    child: const Text(
                                      "Cancel",
                                    ),
                                  ),

                                  TextButton(

                                    onPressed: () {

                                      Navigator.pop(context, true);
                                    },

                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirmDelete == true) {

                            context.read<ExpenseBloc>().add(

                              DeleteExpenseEvent(
                                expenseId: expense.id,
                              ),
                            );

                            deleteLocalExpense(expense.id);
                          }
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Icon(
                        Icons.currency_rupee,
                        color: Colors.green,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${expense.amount}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),


                  Row(
                    children: [
                      const Icon(
                        Icons.category,
                        color: Colors.deepPurple,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        expense.category,
                        style: const TextStyle(
                          color: AppPallete.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: Colors.orange,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('dd MMM yyyy')
                            .format(expense.date),
                        style: const TextStyle(
                          color: AppPallete.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.notes,
                        color: Colors.blue,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          expense.note,
                          style: const TextStyle(
                            color: AppPallete.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}