import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/expense_model.dart';

class ExpenseRemoteDatasource {

  final FirebaseFirestore firestore;

  ExpenseRemoteDatasource(this.firestore);

  Future<void> addExpense(
      ExpenseModel expense) async {

    await firestore
        .collection("expenses")
        .add(expense.toMap());
  }
  Future<void> deleteExpense(
      String expenseId) async {

    await firestore
        .collection("expenses")
        .doc(expenseId)
        .delete();
  }
}