import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  String selectedCategory = "Food";

  DateTime selectedDate = DateTime.now();

  final List<String> categories = [
    "Food",
    "Travel",
    "Shopping",
    "Bills",
    "Health",
  ];

  Future<void> pickDate() async {

    DateTime? pickedDate = await showDatePicker(
      context: context,

      initialDate: selectedDate,

      firstDate: DateTime(2020),

      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Expense"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(
          child: Column(
            children: [

              /// Expense Title
              TextField(
                controller: titleController,

                decoration: InputDecoration(
                  labelText: "Expense Title",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Amount
              TextField(
                controller: amountController,

                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  labelText: "Amount",

                  prefixText: "₹ ",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: selectedCategory,

                items: categories.map((category) {

                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );

                }).toList(),

                onChanged: (value) {

                  setState(() {
                    selectedCategory = value!;
                  });

                },

                decoration: InputDecoration(
                  labelText: "Category",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 15,
                ),

                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [

                    Text(
                      "${selectedDate.day}/"
                          "${selectedDate.month}/"
                          "${selectedDate.year}",
                    ),

                    IconButton(
                      onPressed: pickDate,

                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: noteController,

                maxLines: 3,

                decoration: InputDecoration(
                  labelText: "Notes",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,

                height: 55,

                child: ElevatedButton(
                  onPressed: () {

                    print(titleController.text);
                    print(amountController.text);
                    print(selectedCategory);

                  },

                  child: const Text(
                    "Save Expense",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
