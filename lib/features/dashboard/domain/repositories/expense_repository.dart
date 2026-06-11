import '../entities/expense_entity.dart';

abstract class ExpenseRepository {

  Future<void> addExpense(
      ExpenseEntity expense);
  Future<void> deleteExpense(
      String expenseId,
      );
}