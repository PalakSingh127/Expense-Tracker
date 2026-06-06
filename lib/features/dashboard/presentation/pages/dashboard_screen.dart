import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';
import '../../data/datasources/expense_remote_datasource.dart';
import '../../data/repositories/expense_repository_impl.dart';
import '../../domain/usecases/add_expense_usecase.dart';
import '../bloc/expense_bloc.dart';
import '../widgets/expense_pie_chart.dart';
import '../widgets/transaction_container.dart';
import '../widgets/add_expenses_page.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Stack(
        children: [
          Positioned.fill(child: Opacity(opacity: 0.50,
          child: Image(
            image: AssetImage("assets/img.jpeg"),
            fit: BoxFit.fill,

          )
            ,))
        ],
      )),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) => BlocProvider(

                create: (context) => ExpenseBloc(

                  AddExpenseUseCase(

                    ExpenseRepositoryImpl(

                      ExpenseRemoteDatasource(
                        FirebaseFirestore.instance,
                      ),
                    ),
                  ),
                ),

                child: const AddExpensePage(),
              ),
            ),
          );
        },
        child: CircleAvatar(
          maxRadius: 30,
          backgroundColor: AppPallete.containerColor,

          child: Icon(
            Icons.add_outlined,
            color: AppPallete.borderColor,
          ),
        ),
      ),

    );
  }
}
