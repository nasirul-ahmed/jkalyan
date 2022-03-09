import 'package:devbynasirulahmed/models/loan_customer.dart';
import 'package:devbynasirulahmed/models/loan_repayment.dart';
import 'package:devbynasirulahmed/services/date.format.dart';
import 'package:flutter/material.dart';

class RepaymentRepie extends StatelessWidget {
  final LoanRepayment doc;
  final name;
  const RepaymentRepie({Key? key, required this.doc, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reciept"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "Janakalyan NGO",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      "Bechimari - 784514",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CustomRows(
                data: "$name",
                label: "Name",
              ),
              CustomRows(
                data: "${formatDate(doc.createdAt)}",
                label: "RepDate",
              ),
              CustomRows(
                data: "${formatDate(doc.dueDate)}",
                label: "Due Date",
              ),
              CustomRows(
                data: "${doc.loanInterest}",
                label: "Interest",
              ),
              CustomRows(
                data: "${doc.interestPaid}",
                label: "Interest",
              ),
              CustomRows(
                data: "${doc.repaymentAmount}",
                label: "Repayment",
              ),
              CustomRows(
                data: "${doc.totalPaidAmount}",
                label: "Amount",
              ),
              CustomRows(
                data: "${doc.remLoanAmnt}",
                label: "Remaining",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRows extends StatelessWidget {
  final data;
  final label;
  const CustomRows({Key? key, required this.data, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(
      fontSize: 15,
    );
    const style2 = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: style1,
        ),
        Text(
          data,
          style: style2,
        ),
      ],
    );
  }
}
