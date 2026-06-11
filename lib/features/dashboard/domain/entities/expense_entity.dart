class ExpenseEntity {
  final String id;
  final String uid;
  final String title;
  final double amount;
  final String category;
  final String note;
  final DateTime date;

  ExpenseEntity({
    required this.id,
    required this.uid,
    required this.title,
    required this.amount,
    required this.category,
    required this.note,
    required this.date,
  });
}