import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';

import '../bloc/expense_bloc.dart';
import '../bloc/expense_event.dart';
import '../bloc/expense_state.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() =>
      _AddExpensePageState();
}

class _AddExpensePageState
    extends State<AddExpensePage> {

  final titleController =
  TextEditingController();

  final amountController =
  TextEditingController();

  final noteController =
  TextEditingController();

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

    DateTime? pickedDate =
    await showDatePicker(

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
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.borderColor,
        title: const Text("Add Expense"),
      ),
      body: BlocConsumer<
          ExpenseBloc,
          ExpenseState>(
        listener: (context, state) {
          if (state is ExpenseSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(

              const SnackBar(
                backgroundColor: AppPallete.borderColor,
                content: Text(
                  "Expense Added Successfully",
                ),
              ),
            );

            Navigator.pop(context);
          }

          if (state is ExpenseFailure) {

            ScaffoldMessenger.of(context)
                .showSnackBar(

              SnackBar(
                content: Text(
                  state.message,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller:
                    titleController,
                    decoration:
                    InputDecoration(
                      labelText:
                      "Expense Title",
                      labelStyle: TextStyle(
                        color: AppPallete.borderColor,
                      ),
                      border:
                      OutlineInputBorder(

                        borderRadius:
                        BorderRadius
                            .circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller:
                    amountController,

                    keyboardType:
                    TextInputType
                        .number,

                    decoration:
                    InputDecoration(
                      labelText:
                      "Amount",
                      prefixText:
                      "₹ ",
                      labelStyle: TextStyle(
                        color: AppPallete.borderColor
                      ),
                      border:
                      OutlineInputBorder(
                        borderRadius:
                        BorderRadius
                            .circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownButtonFormField<
                      String>(
                    value:
                    selectedCategory,

                    items: categories
                        .map((category) {

                      return DropdownMenuItem(
                        value: category,

                        child: Text(
                          category,
                        ),
                      );

                    }).toList(),

                    onChanged: (value) {

                      setState(() {

                        selectedCategory =
                        value!;
                      });
                    },

                    decoration:
                    InputDecoration(

                      labelText:
                      "Category",
                      labelStyle: TextStyle(
                        color: AppPallete.borderColor
                      ),

                      border:
                      OutlineInputBorder(

                        borderRadius:
                        BorderRadius
                            .circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(

                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 12,
                      vertical: 15,
                    ),

                    decoration:
                    BoxDecoration(

                      border: Border.all(
                        color: AppPallete.borderColor,
                      ),

                      borderRadius:
                      BorderRadius
                          .circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        Text(
                          "${selectedDate.day }/"
                              "${selectedDate.month}/"
                              "${selectedDate.year}",
                          style: TextStyle(
                            color: AppPallete.borderColor,
                          ),
                        ),

                        IconButton(
                          onPressed:
                          pickDate,
                          icon: const Icon(
                            Icons
                                .calendar_month,
                            color: AppPallete.borderColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller:
                    noteController,
                    maxLines: 3,
                    decoration:
                    InputDecoration(
                      labelText:
                      "Notes",
                      labelStyle: TextStyle(
                        color: AppPallete.borderColor
                      ),
                      border:
                      OutlineInputBorder(
                        borderRadius:
                        BorderRadius
                            .circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width:
                    double.infinity,
                    height: 55,
                    child:
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPallete.borderColor
                      ),
                      onPressed: () {
                        if (titleController
                            .text
                            .isEmpty ||
                            amountController
                                .text
                                .isEmpty) {
                          ScaffoldMessenger
                              .of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please fill all fields",
                              ),
                            ),
                          );

                          return;
                        }

                        context
                            .read<
                            ExpenseBloc>()
                            .add(

                          AddExpenseEvent(

                            title:
                            titleController
                                .text,

                            amount:
                            double.parse(
                              amountController
                                  .text,
                            ),

                            category:
                            selectedCategory,

                            note:
                            noteController
                                .text,
                          ),
                        );
                      },
                      child:
                      state
                      is ExpenseLoading
                          ? const SizedBox(
                        height: 22,
                        width: 22,
                        child:
                        CircularProgressIndicator(
                          strokeWidth:
                          2,
                          color: AppPallete.borderColor,
                        ),
                      )
                          : const Text(
                        "Save Expense",
                        style:
                        TextStyle(
                          fontSize:
                          18,
                          color: AppPallete.containerColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}