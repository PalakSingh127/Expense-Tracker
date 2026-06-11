import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_clean_architecture/features/profile/presentation/pages/profile_screen.dart';

import '../../data/datasource/expense_remote_datasource.dart';
import '../../data/models/expense_model.dart';
import '../../data/repositories/expense_repository_impl.dart';
import '../../domain/usecases/add_expense_usecase.dart';
import '../../domain/usecases/delete_expense_usecase.dart';
import '../bloc/expense_bloc.dart';
import '../widgets/expense_pie_chart.dart';
import '../widgets/top_three_container.dart';
import '../widgets/add_expenses_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<ExpenseModel> expenses = [];

  @override
  void initState() {
    super.initState();
    fetchExpenses();
  }

  Future<void> fetchExpenses() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection('expenses')
        .where('uid', isEqualTo: uid)
        .get();

    expenses = snapshot.docs.map((doc) {

      return ExpenseModel.fromMap(
        {
          ...doc.data(),
          'id': doc.id,
        },
      );

    }).toList();

    setState(() {});
  }
  ExpenseBloc _createExpenseBloc() {
    final firestore = FirebaseFirestore.instance;

    final dataSource = ExpenseRemoteDatasource(firestore);
    final repository = ExpenseRepositoryImpl(dataSource);

    final addUseCase = AddExpenseUseCase(repository);
    final deleteUseCase = DeleteExpenseUseCase(repository);

    return ExpenseBloc(addUseCase, deleteUseCase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppPallete.backgroundColor,

        leading: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            String name = "";

            if (snapshot.hasData && snapshot.data!.exists) {
              name = snapshot.data!['name'] ?? "";
            }

            return Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                  setState(() {});
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppPallete.borderColor,
                  child: name.isEmpty
                      ? const Icon(Icons.person, color: Colors.white)
                      : Text(
                          name[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                ),
              ),
            );
          },
        ),

        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Statistics",
            style: TextStyle(color: AppPallete.textColor),
          ),
        ),

        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                  (route) => false,
                );
              }
            },
            icon: const Icon(Icons.logout, color: AppPallete.borderColor),
          ),
        ],
      ),

      body: expenses.isEmpty
          ? Center(
            child: Text("No Statistics\nAdd your expenses", textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,

            
            color:AppPallete.borderColor
                    ),
            
                  ),
          )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  ExpensePieChart(expenses: expenses),

                  TopTransactionWidget(
                    expenses: expenses,
                    onRefresh: fetchExpenses,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ClipPath(
                      clipper: TopCenterCutClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppPallete.containerColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Expenses",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppPallete.textColor,
                                    ),
                                  ),
                                  Text(
                                    "Amount",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppPallete.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: expenses.length,
                              itemBuilder: (context, index) {
                                final expense = expenses[index];

                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: AppPallete.containerColor,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppPallete.borderColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            expense.title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: AppPallete.borderColor,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            expense.category,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "₹${expense.amount}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

      floatingActionButton: GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => _createExpenseBloc(),
                child: const AddExpensePage(),
              ),
            ),
          );

          await fetchExpenses();
        },
        child: CircleAvatar(
          maxRadius: 30,
          backgroundColor: AppPallete.borderColor,
          child: const Icon(
            Icons.add_outlined,
            color: AppPallete.containerColor,
          ),
        ),
      ),
    );
  }
}

class TopCenterCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2 - 40, 0);
    path.quadraticBezierTo(size.width / 2, 40, size.width / 2 + 40, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
