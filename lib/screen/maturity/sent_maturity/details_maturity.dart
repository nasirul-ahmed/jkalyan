import 'package:devbynasirulahmed/services/format_date.dart';
import 'package:flutter/material.dart';
import 'package:devbynasirulahmed/models/maturity_model.dart';

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
          ],
        ));
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
