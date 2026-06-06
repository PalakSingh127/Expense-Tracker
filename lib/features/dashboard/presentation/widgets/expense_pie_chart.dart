import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePieChart extends StatelessWidget {

  const ExpensePieChart({super.key});

  @override
  Widget build(BuildContext context) {

    return SizedBox(

      height: 250,

      child: PieChart(

        PieChartData(

          centerSpaceRadius: 70,

          sectionsSpace: 2,

          sections: [

            PieChartSectionData(
              value: 40,
              color: Colors.deepPurple,
              radius: 30,
              showTitle: false,
            ),

            PieChartSectionData(
              value: 30,
              color: Colors.yellow,
              radius: 30,
              showTitle: false,
            ),

            PieChartSectionData(
              value: 20,
              color: Colors.purpleAccent,
              radius: 30,
              showTitle: false,
            ),

            PieChartSectionData(
              value: 10,
              color: Colors.grey.shade300,
              radius: 30,
              showTitle: false,
            ),
          ],
        ),
      ),
    );
  }
}