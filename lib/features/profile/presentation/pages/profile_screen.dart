import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';

import '../../../auth/presentation/pages/login_page.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  final TextEditingController
  nameController =
  TextEditingController();

  String savedName = "";

  double totalExpenses = 0;

  double monthlyExpenses = 0;

  @override
  void initState() {

    super.initState();

    getUserData();

    getExpenseData();
  }

  Future<void> getUserData() async {

    final uid =
        FirebaseAuth
            .instance
            .currentUser!
            .uid;

    final doc =
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists) {

      savedName =
          doc['name'] ?? "";

      nameController.text =
          savedName;

      setState(() {});
    }
  }

  Future<void> getExpenseData() async {

    final uid =
        FirebaseAuth
            .instance
            .currentUser!
            .uid;

    final snapshot =
    await FirebaseFirestore.instance
        .collection('expenses')
        .where(
      'uid',
      isEqualTo: uid,
    )
        .get();

    double total = 0;

    double monthly = 0;

    final now = DateTime.now();

    for (var doc in snapshot.docs) {

      final data = doc.data();

      final amount =
      data['amount'];

      total += amount;

      final expenseDate =
      DateTime.parse(
        data['date'],
      );

      if (expenseDate.month ==
          now.month &&
          expenseDate.year ==
              now.year) {

        monthly += amount;
      }
    }

    totalExpenses = total;

    monthlyExpenses = monthly;

    setState(() {});
  }

  Future<void> saveName() async {

    final uid =
        FirebaseAuth
            .instance
            .currentUser!
            .uid;

    final email =
        FirebaseAuth
            .instance
            .currentUser!
            .email;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({

      "uid": uid,

      "email": email,

      "name":
      nameController.text,
    });

    savedName =
        nameController.text;

    setState(() {});

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          "Name Updated",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final user =
        FirebaseAuth.instance.currentUser;

    return Scaffold(

      backgroundColor:
      AppPallete.backgroundColor,

      appBar: AppBar(

        backgroundColor:
        AppPallete.borderColor,

        title: const Text(
          "Profile",
        ),
        actions: [

          IconButton(

            onPressed: () async {

              await FirebaseAuth.instance
                  .signOut();

              if (context.mounted) {

                Navigator.pushAndRemoveUntil(

                  context,

                  MaterialPageRoute(
                      builder: (_) => LoginPage()
                  ),
                      (route) => false,
                );
              }
            },
            icon: const Icon(
              Icons.logout,
              color: AppPallete.containerColor,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(

        child: Center(

          child: Padding(

            padding:
            const EdgeInsets.all(20),

            child: Column(

              children: [

                // PROFILE IMAGE
                Stack(

                  children: [

                    CircleAvatar(

                      radius: 60,

                      backgroundColor:
                      AppPallete.borderColor,

                      child: savedName.isEmpty

                          ? const Icon(

                        Icons.person,

                        size: 60,

                        color:
                        AppPallete.containerColor,
                      )

                          : Text(

                        savedName
                            .trim()
                            .split(' ')
                            .map(
                              (e) => e[0],
                        )
                            .take(2)
                            .join()
                            .toUpperCase(),

                        style:
                        const TextStyle(

                          fontSize: 45,

                          fontWeight:
                          FontWeight.bold,

                          color:
                          AppPallete.containerColor,
                        ),
                      ),
                    ),

                    Positioned(

                      bottom: 0,

                      right: 0,

                      child: GestureDetector(

                        onTap: () {

                          showDialog(

                            context: context,

                            builder: (context) {

                              return AlertDialog(

                                shape:
                                RoundedRectangleBorder(

                                  borderRadius:
                                  BorderRadius.circular(
                                    20,
                                  ),
                                ),

                                title:
                                const Text(
                                  "Edit Name",
                                ),

                                content:
                                TextField(

                                  controller:
                                  nameController,

                                  decoration:
                                  InputDecoration(

                                    hintText:
                                    "Enter Name",

                                    border:
                                    OutlineInputBorder(

                                      borderRadius:
                                      BorderRadius.circular(
                                        12,
                                      ),
                                    ),
                                  ),
                                ),

                                actions: [

                                  TextButton(

                                    onPressed: () {

                                      Navigator.pop(
                                          context);
                                    },

                                    child:
                                    const Text(
                                      "Cancel",
                                    ),
                                  ),

                                  ElevatedButton(

                                    onPressed:
                                        () async {

                                      await saveName();

                                      if (context
                                          .mounted) {

                                        Navigator.pop(
                                            context);
                                      }
                                    },

                                    child:
                                    const Text(
                                      "Save",
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },

                        child: Container(

                          padding:
                          const EdgeInsets.all(
                            8,
                          ),

                          decoration:
                          BoxDecoration(

                            color:
                            AppPallete.borderColor,

                            shape:
                            BoxShape.circle,

                            border: Border.all(

                              color:
                              Colors.white,

                              width: 2,
                            ),
                          ),

                          child: const Icon(

                            Icons.edit,

                            size: 18,

                            color:
                            AppPallete.containerColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                // EMAIL
                Text(

                  user?.email ?? "",

                  style:
                  const TextStyle(

                    fontSize: 18,

                    fontWeight:
                    FontWeight.w500,

                    color: Colors.grey,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                Text(
                  savedName.isEmpty
                      ? "No Name Added"
                      : savedName,
                  style:
                  const TextStyle(
                    fontSize: 24,
                    fontWeight:
                    FontWeight.bold,
                    color:
                    AppPallete.textColor,
                  ),
                ),

                const SizedBox(
                  height: 35,
                ),
                Container(

                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(
                    18,
                  ),
                  decoration: BoxDecoration(
                    color:
                    AppPallete.containerColor,
                    borderRadius:
                    BorderRadius.circular(
                      20,
                    ),

                    border: Border.all(

                      color:
                      AppPallete.borderColor,

                      width: 2,
                    ),

                    boxShadow: [

                      BoxShadow(

                        color: Colors.black
                            .withOpacity(0.08),

                        blurRadius: 10,

                        offset:
                        const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Row(

                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                    children: [

                      Row(

                        children: [

                          Container(

                            padding:
                            const EdgeInsets
                                .all(12),

                            decoration:
                            BoxDecoration(

                              color:
                              AppPallete
                                  .borderColor,

                              borderRadius:
                              BorderRadius.circular(
                                15,
                              ),
                            ),

                            child: const Icon(

                              Icons.account_balance_wallet,
                              color:
                              Colors.white,
                              size: 28,
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          const Text(
                            "Total Expenses",
                            style:
                            TextStyle(

                              fontSize: 18,

                              fontWeight:
                              FontWeight.bold,

                              color:
                              AppPallete.textColor,
                            ),
                          ),
                        ],
                      ),

                      Text(

                        "₹${totalExpenses.toStringAsFixed(0)}",

                        style:
                        const TextStyle(

                          fontSize: 22,

                          fontWeight:
                          FontWeight.bold,

                          color:
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Container(

                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(
                    18,
                  ),

                  decoration: BoxDecoration(

                    color:
                    AppPallete.containerColor,

                    borderRadius:
                    BorderRadius.circular(
                      20,
                    ),

                    border: Border.all(

                      color: Colors.green,

                      width: 2,
                    ),

                    boxShadow: [

                      BoxShadow(

                        color: Colors.black
                            .withOpacity(0.08),

                        blurRadius: 10,

                        offset:
                        const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Row(

                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                    children: [

                      Row(

                        children: [

                          Container(

                            padding:
                            const EdgeInsets
                                .all(12),

                            decoration:
                            BoxDecoration(

                              color:
                              Colors.green,

                              borderRadius:
                              BorderRadius.circular(
                                15,
                              ),
                            ),

                            child: const Icon(

                              Icons.calendar_month,

                              color:
                              Colors.white,

                              size: 28,
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          const Text(

                            "Monthly Expenses",
                            style:
                            TextStyle(

                              fontSize: 18,

                              fontWeight:
                              FontWeight.bold,

                              color:
                              AppPallete.textColor,
                            ),
                          ),
                        ],
                      ),

                      Text(

                        "₹${monthlyExpenses.toStringAsFixed(0)}",

                        style:
                        const TextStyle(

                          fontSize: 20,

                          fontWeight:
                          FontWeight.bold,

                          color:
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}