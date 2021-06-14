import 'dart:math';

import 'package:devbynasirulahmed/screen/add_customer/add_loan/review_loan.dart';
import 'package:devbynasirulahmed/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class AddLoanCustomer extends StatefulWidget {
  @override
  _AddLoanCustomerState createState() => _AddLoanCustomerState();
}

class _AddLoanCustomerState extends State<AddLoanCustomer> {
  final _key = GlobalKey<FormState>();

  TextEditingController loanInstallment = TextEditingController();
  TextEditingController loanAmount = TextEditingController();
  TextEditingController recoveryType = TextEditingController();

  String createdAt = '';
  @override
  Widget build(BuildContext context) {
    Future<void> _selectCreatedAt(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        setState(() {
          createdAt = "${picked.year}-${picked.month}-${picked.day}";
        });
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _key,
        child: Column(
          children: [
            customTextField(
                "Total Loan Amount", TextInputType.number, loanAmount),
            customTextField(
                "Loan Installment", TextInputType.number, loanInstallment),
            customTextField(
                "Loan Installment", TextInputType.number, loanInstallment),
            customTextField("Recovery Type", TextInputType.text, recoveryType),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InkWell(
                onTap: () => _selectCreatedAt(context),
                child: IgnorePointer(
                  child: TextField(
                    //controller: maturityDate,
                    decoration: InputDecoration(
                      labelText: createdAt.isEmpty ? 'Created At' : createdAt,
                      hintText: (createdAt),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
