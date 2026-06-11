import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';

import '../../data/models/expense_model.dart';

class ExpensePieChart extends StatelessWidget {

  final List<ExpenseModel> expenses;

  const ExpensePieChart({
    super.key,
    required this.expenses,
  });
  String getCategoryEmoji(String category) {

    switch(category) {

      case "Food":
        return "🍔";

      case "Travel":
        return "✈";

      case "Shopping":
        return "🛍";

      case "Bills":
        return "🧾";

      case "Health":
        return "🏥";

      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> categoryColors = {

      "Food": Colors.orange,

      "Travel": Colors.blue,

      "Shopping": Colors.purple,

      "Bills": Colors.red,

      "Health": Colors.green,
    };
    Map<String, double> totals = {

      "Food": 0,
      "Travel": 0,
      "Shopping": 0,
      "Bills": 0,
      "Health": 0,
    };

    double totalExpense = 0;
    for (var expense in expenses) {

      totals[expense.category] =
          totals[expense.category]! +
              expense.amount;

      totalExpense += expense.amount;
    }
    if (expenses.isEmpty) {
      return SizedBox(
        height: 300,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 100,
                    color: Colors.grey,
                    title: " ",
                    radius: 50,
                  ),
                ],
                centerSpaceRadius: 85,
                sectionsSpace: 3,
              ),
            ),
            const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "No Data",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sections: totals.entries.map((entry) {
                return PieChartSectionData(
                  value: entry.value,
                  color: categoryColors[entry.key],
                  title: getCategoryEmoji(entry.key),
                  radius: 50,
                  titleStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );

              }).toList(),

              centerSpaceRadius: 85,

              sectionsSpace: 3,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  fontSize: 16,
                  color: AppPallete.textColor
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "₹${totalExpense.toInt()}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.borderColor
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}