import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/expense_entity.dart';
import '../../domain/usecases/add_expense_usecase.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc
    extends Bloc<ExpenseEvent, ExpenseState> {

  final AddExpenseUseCase addExpenseUseCase;

  ExpenseBloc(this.addExpenseUseCase)
      : super(ExpenseInitial()) {

    on<AddExpenseEvent>((event, emit)
    async {

      emit(ExpenseLoading());

      try {

        await addExpenseUseCase.call(

          ExpenseEntity(
            title: event.title,
            amount: event.amount,
            category: event.category,
            note: event.note,
          ),
        );

        emit(ExpenseSuccess());

      } catch (e) {

        emit(
          ExpenseFailure(e.toString()),
        );
      }
    });
  }
}