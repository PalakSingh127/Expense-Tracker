import '../entities/expense_entity.dart';
import '../repositories/expense_repository.dart';

class AddExpenseUseCase {

  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);

  Future<void> call(
      ExpenseEntity expense) async {

    await repository.addExpense(expense);
  }
}