import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';

class TransactionContainer extends StatelessWidget {

  const TransactionContainer({super.key});

  @override
  Widget build(BuildContext context) {

    return  Container(
      width:350,
      decoration: BoxDecoration(
        color: AppPallete.containerColor,
        borderRadius: BorderRadius.circular(5)
      ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text('TRANSACTIONS',
              style: TextStyle(
                color: AppPallete.textColor,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 100,),
            Text("Today",
              style: TextStyle(
                color: AppPallete.textColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),

    );
  }
}
