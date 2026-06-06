import '../../domain/entities/expense_entity.dart';

class ExpenseModel extends ExpenseEntity {

  ExpenseModel({
    required super.title,
    required super.amount,
    required super.category,
    required super.note,
  });

  Map<String, dynamic> toMap() {

    return {
      "title": title,
      "amount": amount,
      "category": category,
      "note": note,
    };
  }
}