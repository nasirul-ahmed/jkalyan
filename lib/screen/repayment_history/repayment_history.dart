import 'package:devbynasirulahmed/models/loan_repayment.dart';
import 'package:devbynasirulahmed/screen/repayment_history/repayment_reciept.dart';
import 'package:devbynasirulahmed/services/date.format.dart';
import 'package:devbynasirulahmed/services/loan_repaymnet/loan_repayment_services.dart';
import 'package:flutter/material.dart';

class RepaymentHistory extends StatelessWidget {
  final loanAcNo;
  final name;
  final loanAmount;
  final nextDue;
  final depositAcNo;
  RepaymentHistory(
      {Key? key,
      required this.loanAcNo,
      required this.name,
      required this.loanAmount,
      required this.nextDue,
      required this.depositAcNo,
      
      })
      : super(key: key);

  LoanRepaymentServices loanRepaymentServices = LoanRepaymentServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Repayment History"),
      ),
      body: Container(
          child: FutureBuilder<List<LoanRepayment>>(
        future: loanRepaymentServices.getLoanRepayments(loanAcNo),
        builder: (____, snap) {
          if (snap.hasData) {
            return renderDatatable(context, snap.data, name, loanAmount, nextDue, depositAcNo);
            
          } else if (snap.hasError) {
            return Center(child: Text("Something Error"));
          } else {
            return Center(child: CircularProgressIndicator.adaptive());
          }
        },
      )),
    );
  }
}

SingleChildScrollView renderDatatable(BuildContext context,
    List<LoanRepayment>? list, String name, int loanAmount, String nextDue, int depositAcNo) {
  void navigate(context, document) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => RepaymentRepie(
                doc: document,
                name: name,
                loanAmount: loanAmount,
                nextDue: nextDue, depositAcNo: depositAcNo,)));
  }

  TextStyle style = TextStyle(color: Colors.black, fontSize: 12);
  TextStyle style1 = TextStyle(color: Colors.black, fontSize: 12);
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 10,
        horizontalMargin: 10,
        columns: [
          DataColumn(label: Text('Date', style: style1)),
          DataColumn(label: Text('Interest', style: style1)),
          DataColumn(label: Text('Int Paid', style: style1)),
          DataColumn(label: Text('Repayment', style: style1)),
          DataColumn(label: Text('Total Paid', style: style1)),
          DataColumn(label: Text('Rem L. amnt', style: style1)),
        ],
        rows: list!.map((LoanRepayment document) {
          return DataRow(cells: [
            DataCell(
              Text(
                '${formatDate(document.createdAt)}',
                style: style,
              ),
              onTap: () => navigate(context, document),
            ),
            DataCell(
              Text(
                '${document.loanInterest}',
                style: style,
              ),
              onTap: () => navigate(context, document),
            ),
            DataCell(
              Text(
                '${document.interestPaid}',
                style: style,
              ),
              onTap: () => navigate(context, document),
            ),
            DataCell(
              Text(
                '${document.repaymentAmount}',
                style: style,
              ),
              onTap: () => navigate(context, document),
            ),
            DataCell(
              Text(
                '${document.totalPaidAmount}',
                style: style,
              ),
              onTap: () => navigate(context, document),
            ),
            DataCell(
              Text(
                '${document.remLoanAmnt}',
                style: style,
              ),
              onTap: () => navigate(context, document),
            ),
          ]);
        }).toList(),
      ),
    ),
  );
}
