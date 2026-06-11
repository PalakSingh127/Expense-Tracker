import '../../domain/entities/expense_entity.dart';

class ExpenseModel extends ExpenseEntity {

  ExpenseModel({

    required super.id,
    required super.uid,
    required super.title,
    required super.amount,
    required super.category,
    required super.note,
    required super.date,
  });

  Map<String, dynamic> toMap() {

    return {

      "id": id,
      "uid": uid,
      "title": title,
      "amount": amount,
      "category": category,
      "note": note,
      "date": date.toIso8601String(),
    };
  }

  factory ExpenseModel.fromMap(
      Map<String, dynamic> map) {

    return ExpenseModel(

      id: map['id'] ?? "",

      uid: map['uid'],

      title: map['title'],

      amount:
      map['amount'].toDouble(),

      category:
      map['category'],

      note:
      map['note'],

      date: DateTime.parse(
        map['date'],
      ),
    );
  }
}