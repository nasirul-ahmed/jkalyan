import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:devbynasirulahmed/services/date.format.dart';
import 'package:devbynasirulahmed/services/format_date.dart';
import 'package:flutter/material.dart';
import 'package:devbynasirulahmed/models/maturity_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import "package:pdf/pdf.dart";

class DetailsMaturity extends StatefulWidget {
  DetailsMaturity({Key? key, this.doc}) : super(key: key);
  final MaturityModel? doc;

  @override
  _DetailsMaturityState createState() => _DetailsMaturityState();
}

class _DetailsMaturityState extends State<DetailsMaturity> {
  String? submitDate;

  String? openingDate;

  String? processDate;

  formate() {
    submitDate = formateDate(widget.doc?.submitDate);
    openingDate = formateDate(widget.doc?.openingDate);
    processDate = formateDate(widget.doc?.processDate);
  }

  @override
  void initState() {
    super.initState();
    formate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
          actions: [
            ElevatedButton(
              onPressed: handleClick,
              child: Text("Download"),
            ),
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: Container(
                ///padding: EdgeInsets.all(10),
                height: 50,
                width: MediaQuery.of(context).size.width - 20,
                color: Colors.blue[900],
                child: Center(
                  child: Text(
                    widget.doc!.isPreMaturity == 1
                        ? "Account Pre Maturity"
                        : "Account Maturity",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            customContainer("Maturity Type",
                widget.doc!.isPreMaturity == 1 ? "Pre Maturity" : "Maturity"),
            SizedBox(
              height: 20,
              child: Divider(
                height: 1,
              ),
            ),
            customContainer("Passbook Rcv. Date", submitDate),
            SizedBox(
              height: 20,
              child: Divider(
                height: 1,
              ),
            ),
            customContainer("Passbook Opening Date", openingDate),
            SizedBox(
              height: 20,
              child: Divider(
                height: 1,
              ),
            ),
            customContainer("Process Date", processDate),
            SizedBox(
              height: 20,
              child: Divider(
                height: 1,
              ),
            ),
            customContainer("Account Number", widget.doc!.accountNumber),
            SizedBox(
              height: 20,
              child: Divider(
                height: 1,
              ),
            ),
            customContainer("Name", widget.doc!.custName),
            SizedBox(
              height: 20,
              child: Divider(
                height: 1,
              ),
            ),
            customContainer("C/o", widget.doc!.fathersName),
            SizedBox(
              height: 20,
              child: Divider(
                height: 1,
              ),
            ),
            customContainer("Address", widget.doc!.address),
            SizedBox(
              height: 20,
              child: Divider(
                height: 1,
              ),
            ),
            customContainer("Scheme Value", widget.doc!.maturityValue),
            SizedBox(
              height: 20,
              child: Divider(
                height: 1,
              ),
            ),
            customContainer(
              "Total Deposit Amount",
              widget.doc!.maturityAmount,
            ),
            SizedBox(
              height: 20,
              child: Divider(
                height: 1,
              ),
            ),
            customContainer("Maturity Interest Amount",
                "+ " + "${widget.doc!.maturityInterest}"),
            SizedBox(
              height: 20,
              child: Divider(
                height: 1,
              ),
            ),
            customContainer("Pre-Maturity Charge",
                "- " + "${widget.doc!.preMaturityCharge}"),
            SizedBox(
              height: 20,
              child: Divider(
                height: 1,
              ),
            ),
            customContainer(
                "Loss (for any loan/interest)", "- " + "${widget.doc!.loss}"),
            SizedBox(
              height: 20,
              child: Divider(
                height: 1,
                thickness: 2,
              ),
            ),
            customContainer("Net Payable Amount",
                "Rs.  " + widget.doc!.totalAmount.toString() + "  /-"),
            SizedBox(height: 50),
            ElevatedButton(onPressed: handleClick, child: Text("Download Pdf")),
          ],
        ));
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
                    widget.doc!.isPreMaturity! == 0
                        ? "Maturity"
                        : "Pre Maturity",
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
                      pw.Text(widget.doc!.custName.toString()),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Father Name"),
                      pw.Text(widget.doc!.fathersName.toString()),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Address"),
                      pw.Text(widget.doc!.address.toString()),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Account Number"),
                      pw.Text(widget.doc!.accountNumber.toString()),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Collector Code"),
                      pw.Text(widget.doc!.collectorId.toString()),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("A/c Opening Date"),
                      pw.Text(formatDate(widget.doc!.openingDate)),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Submission Date"),
                      pw.Text(formatDate(widget.doc!.submitDate)),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Processing Date"),
                      pw.Text(formatDate(widget.doc!.processDate)),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Maturity Value (Rs)"),
                      pw.Text(widget.doc!.maturityValue.toString()),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Maturity / Deposit Amount (Rs)"),
                      pw.Text(widget.doc!.maturityAmount.toString()),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  widget.doc!.isPreMaturity! == 0
                      ? pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Maturity Intrest Amount (Rs)"),
                            pw.Text("+  " +
                                widget.doc!.maturityInterest.toString()),
                          ],
                        )
                      : pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Pre Maturity Charge (Rs)"),
                            pw.Text("-  " +
                                widget.doc!.preMaturityCharge.toString()),
                          ],
                        ),
                  pw.SizedBox(height: 5),
                  pw.Divider(),
                  pw.SizedBox(height: 5),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Net Payable Amount (Rs)"),
                      pw.Text(
                          "=  " + widget.doc!.totalAmount.toString() + " /-"),
                    ],
                  ),
                  pw.Divider(),
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Text(
                      "I've recieved the amount as mentioned above in full as per Samittees Scheme deposited by me and I've no claim against the Society and to the Account."),
                  pw.SizedBox(
                    height: 40,
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Collector (signature)"),
                        pw.Text("Account Holder (Signature/Thumb)")
                      ]),
                  pw.Divider(),
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
    final filename = "maturity_statement(ac-${widget.doc!.accountNumber}).pdf";

    final file = File("$path/$filename");
    //Uint8List pdfInBytes = await pdf.save();

    await file.writeAsBytes(await pdf.save(), flush: true);
    OpenFile.open('$path/$filename');
  }

  Widget customContainer(String hint, dynamic hintValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            hint,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '$hintValue',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
