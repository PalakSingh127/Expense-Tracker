import '../../domain/entities/expense_entity.dart';
import '../../domain/repositories/expense_repository.dart';

import '../datasource/expense_remote_datasource.dart';
import '../datasources/expense_remote_datasource.dart';
import '../models/expense_model.dart';

class ExpenseRepositoryImpl
    implements ExpenseRepository {

  final ExpenseRemoteDatasource datasource;

  ExpenseRepositoryImpl(this.datasource);

  @override
  Future<void> addExpense(
      ExpenseEntity expense) async {

    ExpenseModel model = ExpenseModel(
      title: expense.title,
      amount: expense.amount,
      category: expense.category,
      note: expense.note,
    );

    await datasource.addExpense(model);
  }
}