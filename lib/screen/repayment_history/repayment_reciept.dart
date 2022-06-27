import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import "package:pdf/pdf.dart";
import 'package:devbynasirulahmed/models/loan_repayment.dart';
import 'package:devbynasirulahmed/services/date.format.dart';
import 'package:flutter/material.dart';

class RepaymentRepie extends StatelessWidget {
  final LoanRepayment doc;
  final name;
  final loanAmount;
  final nextDue;
  final depositAcNo;
  const RepaymentRepie(
      {Key? key,
      required this.doc,
      this.name,
      this.loanAmount,
      this.nextDue,
      this.depositAcNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime x = DateTime.parse(nextDue);
    DateTime newDueDate = x.add(Duration(days: 30));
    return Scaffold(
      appBar: AppBar(
        title: Text("Reciept"),
        actions: [
          ElevatedButton(onPressed: handleClick, child: Text("Download")),
        ],
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
                      "Janakalyan Agriculture",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      "&",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Rural Development",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(
                      height: 8,
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
              Divider(),
              CustomRows(
                data: "$name",
                label: "Name",
              ),
              CustomRows(
                data: "${formatDate(doc.createdAt)}",
                label: "Repayment Date",
              ),
              CustomRows(
                data: "${formatDate(doc.dueDate)}",
                label: "Previous Due Date",
              ),
              CustomRows(
                data: "${formatDate(newDueDate)}",
                label: "Next Due Date",
              ),
              CustomRows(
                data: "${doc.loanInterest} /-",
                label: "Loan Interest",
              ),
              CustomRows(
                data: "${doc.collectionAmount} /-",
                label: "Loan Collection",
              ),
              CustomRows(
                data: "${doc.interestPaid} /-",
                label: "Interest Paid",
              ),
              CustomRows(
                data: "${doc.repaymentAmount} /-",
                label: "Repayment Amnt",
              ),
              CustomRows(
                data: "${doc.totalPaidAmount} /-",
                label: "Total Paid Amnt",
              ),
              CustomRows(
                data: "${doc.remLoanAmnt} /-",
                label: "Remaining Loan",
              ),
              Divider(),
              CustomRows(
                data: "$loanAmount /-",
                label: "Loan Sanctioned",
              ),
              ElevatedButton(
                  onPressed: handleClick, child: Text("Download Pdf")),
            ],
          ),
        ),
      ),
    );
  }

  handleClick() async {
    const style = pw.TextStyle(color: PdfColors.red, fontSize: 22);

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              // pw.Center(
              //   child: pw.Text("Header"),
              // ),
              pw.Partition(
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        "JANAKALYAN AGRICULTURE & RURAL DEV. SOCIETY",
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.red,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        "Bechimari :: Darrang (Assam)",
                        style: pw.TextStyle(
                            fontSize: 12, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        "P.O: Bechimari, PIN - 784514 ",
                        style: pw.TextStyle(
                            fontSize: 12, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        "Regd No :: RS/DAR/247/G/20 - 2008",
                        style: pw.TextStyle(
                            fontSize: 12, fontWeight: pw.FontWeight.bold),
                      )
                    ]),
              ),
              pw.Divider(),

              pw.Container(
                //width: MediaQuery.of(pw.Context context).size.width,
                height: 40,
                color: PdfColors.blue,
                child: pw.Center(
                  child: pw.Text(
                    "Repayment Receipt",
                    style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              pw.SizedBox(height: 15),
              pw.Partition(
                child: pw.Column(children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Customer Name"),
                      pw.Text(name.toString()),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Loan Account No"),
                      pw.Text(doc.loanAcNo.toString()),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Deposit Acoount No"),
                      pw.Text(depositAcNo.toString()),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Collector Code"),
                      pw.Text(doc.collectorId.toString()),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("A/c Opening Date"),
                      pw.Text(formatDate(doc.accountCreatedAt)),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Repayment Date"),
                      pw.Text(formatDate(doc.createdAt)),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Due Date"),
                      pw.Text(formatDate(doc.dueDate)),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Next Due Date"),
                      pw.Text(formatDate(nextDue)),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Loan Amount Sanctioned (Rs)"),
                      pw.Text(loanAmount.toString() + " /-"),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Collection Amount(Rs)"),
                      pw.Text(doc.collectionAmount.toString() + " /-"),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Loan Interest(Rs)"),
                      pw.Text(doc.loanInterest.toString() + " /-"),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Loan Interest Paid(Rs)"),
                      pw.Text(doc.interestPaid.toString() + " /-"),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Repayment Amount (Rs)"),
                      pw.Text(doc.repaymentAmount.toString() + " /-"),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Total Paid Amount(Rs)"),
                      pw.Text("-" + doc.totalPaidAmount.toString() + " /="),
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  pw.Divider(),
                  pw.SizedBox(height: 5),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Remaining Loan Amount(Rs)"),
                      pw.Text("= " + doc.remLoanAmnt.toString() + " /="),
                    ],
                  ),
                  pw.SizedBox(
                    height: 40,
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Date:....................."),
                        pw.Text("Collector (Signature)")
                      ]),
                  pw.Divider(),
                  pw.SizedBox(height: 10),
                  pw.Text("*Remarks",
                      style: const pw.TextStyle(
                        decoration: pw.TextDecoration.underline,
                      ))
                ]),
              ),
            ],
          ); // Center
        },
      ),
    );

    final path = (await getExternalStorageDirectory())!.path;
    final filename = "repayment-receipt(loan-no${doc.loanAcNo}).pdf";
    final file = File("$path/$filename");
    await file.writeAsBytes(await pdf.save(), flush: true);
    OpenFile.open('$path/$filename');
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
