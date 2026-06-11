import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/expense_entity.dart';
import '../../domain/repositories/expense_repository.dart';

import '../datasource/expense_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/expense_entity.dart';
import '../../domain/repositories/expense_repository.dart';

import '../datasource/expense_remote_datasource.dart';
import '../models/expense_model.dart';

class ExpenseRepositoryImpl
    implements ExpenseRepository {

  final ExpenseRemoteDatasource datasource;

  ExpenseRepositoryImpl(this.datasource);

  // ADD EXPENSE
  @override
  Future<void> addExpense(
      ExpenseEntity expense) async {

    final uid =
        FirebaseAuth
            .instance
            .currentUser!
            .uid;

    ExpenseModel model = ExpenseModel(

      id: "",

      uid: uid,

      title: expense.title,

      amount: expense.amount,

      category: expense.category,

      note: expense.note,

      date: DateTime.now(),
    );

    await datasource.addExpense(
      model,
    );
  }

  @override
  Future<void> deleteExpense(
      String expenseId) async {

    await datasource.deleteExpense(
      expenseId,
    );
  }
}