import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/expense_entity.dart';
import '../../domain/usecases/add_expense_usecase.dart';
import '../../domain/usecases/delete_expense_usecase.dart';

import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {

  final AddExpenseUseCase addExpenseUseCase;
  final DeleteExpenseUseCase deleteExpenseUseCase;

  ExpenseBloc(
      this.addExpenseUseCase,
      this.deleteExpenseUseCase,
      ) : super(ExpenseInitial()) {

    // ✅ ADD EXPENSE
    on<AddExpenseEvent>((event, emit) async {

      final uid = FirebaseAuth.instance.currentUser!.uid;

      emit(ExpenseLoading());

      try {

        await addExpenseUseCase.call(

          ExpenseEntity(
            id: DateTime.now()
                .millisecondsSinceEpoch
                .toString(),

            uid: uid,
            title: event.title,
            amount: event.amount,
            category: event.category,
            note: event.note,
            date: DateTime.now(),
          ),
        );

        emit(ExpenseSuccess());

      } catch (e) {

        emit(
          ExpenseFailure(e.toString()),
        );
      }
    });

    // ✅ DELETE EXPENSE
    on<DeleteExpenseEvent>((event, emit) async {

      emit(ExpenseLoading());

      try {

        await deleteExpenseUseCase.call(
          event.expenseId,
        );

        emit(ExpenseDeleteSuccess());

      } catch (e) {

        emit(
          ExpenseFailure(e.toString()),
        );
      }
    });
  }
}