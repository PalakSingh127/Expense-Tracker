abstract class ExpenseEvent {}

class AddExpenseEvent
    extends ExpenseEvent {

  final String title;
  final double amount;
  final String category;
  final String note;

  AddExpenseEvent({
    required this.title,
    required this.amount,
    required this.category,
    required this.note,
  });
}