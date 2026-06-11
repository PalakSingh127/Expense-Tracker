import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';
import 'package:flutter_clean_architecture/features/dashboard/presentation/pages/all_expenses_screen.dart';

import '../../data/datasource/expense_remote_datasource.dart';
import '../../data/models/expense_model.dart';
import '../../data/repositories/expense_repository_impl.dart';
import '../../domain/usecases/add_expense_usecase.dart';
import '../../domain/usecases/delete_expense_usecase.dart';
import '../bloc/expense_bloc.dart';

class TopTransactionWidget extends StatelessWidget {

  final List<ExpenseModel> expenses;
  final VoidCallback onRefresh;

  const TopTransactionWidget({
    super.key,
    required this.expenses,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {

    // ✅ CATEGORY TOTAL CALCULATION
    Map<String, double> categoryTotals = {};

    for (var expense in expenses) {

      if (categoryTotals.containsKey(expense.category)) {

        categoryTotals[expense.category] =
            categoryTotals[expense.category]! +
                expense.amount;

      } else {

        categoryTotals[expense.category] =
            expense.amount;
      }
    }

    // ✅ CONVERT MAP TO LIST
    List<MapEntry<String, double>> sortedCategories =
    categoryTotals.entries.toList();

    // ✅ SORT HIGHEST TO LOWEST
    sortedCategories.sort(
          (a, b) => b.value.compareTo(a.value),
    );

    // ✅ TOP 3 CATEGORIES
    final topThree =
    sortedCategories.take(3).toList();

    final List<Color> cardColors = [
      Colors.deepPurple,
      Colors.orange,
      Colors.teal,
    ];

    final List<Color> borderColors = [
      Colors.purpleAccent,
      Colors.deepOrange,
      Colors.greenAccent,
    ];

    if (expenses.isEmpty) {

      return const Center(
        child: Text("No Transactions"),
      );
    }

    return Padding(

      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(

            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              const Text(

                "Top Categories",

                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.textColor,
                ),
              ),

              TextButton(

                onPressed: () async {

                  await Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) => BlocProvider(

                        create: (_) => ExpenseBloc(

                          AddExpenseUseCase(

                            ExpenseRepositoryImpl(

                              ExpenseRemoteDatasource(
                                FirebaseFirestore.instance,
                              ),
                            ),
                          ),

                          DeleteExpenseUseCase(

                            ExpenseRepositoryImpl(

                              ExpenseRemoteDatasource(
                                FirebaseFirestore.instance,
                              ),
                            ),
                          ),
                        ),

                        child: AllExpensesScreen(
                          expenses: expenses,
                        ),
                      ),
                    ),
                  );

                  onRefresh();
                },

                child: const Text(

                  'View All',

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppPallete.textColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ✅ UPDATED LAYOUT
          Wrap(

            spacing: 12,
            runSpacing: 12,

            children: List.generate(

              topThree.length,

                  (index) {

                final category =
                    topThree[index].key;

                final amount =
                    topThree[index].value;

                return Container(

                  height: 150,
                  width: 110,

                  padding:
                  const EdgeInsets.all(12),

                  decoration: BoxDecoration(

                    color: cardColors[index],

                    borderRadius:
                    BorderRadius.circular(
                      25,
                    ),

                    border: Border.all(
                      color: borderColors[index],
                      width: 2,
                    ),

                    boxShadow: [

                      BoxShadow(

                        color: Colors.black
                            .withOpacity(0.12),

                        blurRadius: 8,

                        offset:
                        const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Column(

                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    children: [

                      CircleAvatar(

                        radius: 15,

                        backgroundColor:
                        Colors.white,

                        child: Text(

                          "${index + 1}",

                          style: TextStyle(

                            color:
                            cardColors[index],

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),
                      Text(

                        category,

                        textAlign:
                        TextAlign.center,

                        maxLines: 1,

                        overflow:
                        TextOverflow.ellipsis,

                        style: const TextStyle(

                          color: Colors.white,

                          fontSize: 16,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),
                      Text(

                        "₹${amount.toStringAsFixed(0)}",

                        style: const TextStyle(

                          color: Colors.white,

                          fontSize: 20,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}