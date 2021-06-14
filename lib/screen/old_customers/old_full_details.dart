import 'package:devbynasirulahmed/models/customer.dart';
import 'package:flutter/material.dart';

class OldFullDetails extends StatelessWidget {
  OldFullDetails(this.doc);
  final Customer? doc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "Account: ${doc?.accountNumber}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        //automaticallyImplyLeading: false,
        toolbarHeight: 100,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              customDetails("Name", doc?.name),
              customDetails("Father Name", doc?.fatherName),
              customDetails("Age", doc?.age),
              customDetails("Address", doc?.address),
              customDetails("occupation", doc?.occupation),
              customDetails("Phone", doc?.phone),
              customDetails("Pin", doc?.pinCode),
              customDetails("Nominee Name", doc?.nomineeName),
              customDetails("N. Father", doc?.nomineeFatherName),
              customDetails("N. Age", doc?.nomineeAge),
              customDetails("N. Address", doc?.nomineeAddress),
              customDetails("N. Phone", doc?.nomineePhone),
              customDetails("Relation", doc?.relation),
              customDetails("A/c Type", doc?.accountType),
              customDetails("Interest Rate", doc?.rateOfInterest),
              customDetails("Installment", doc?.installmentAmount),
              customDetails("Total Installment", doc?.totalInstallments),
              customDetails("Interst Amount", doc?.totalInterestAmount),
              customDetails("Prin. Amount", doc?.totalPrincipalAmount),
              customDetails("Matruity Amount", doc?.totalMaturityAmount),
              customDetails("Maturity Date",
                  doc?.maturityDate.toString().substring(0, 10)),
              customDetails(
                  "Opening Date", doc?.createdAt.toString().substring(0, 10)),
              customDetails(
                  "A/C Status", doc?.isActive == 0 ? 'closed' : 'open'),
              SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget customDetails(string, name) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Container(
        height: 55,
        child: Card(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '$string',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          //child: Text(name.toString())),
                          child: RichText(
                            text: TextSpan(
                              text: name.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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
