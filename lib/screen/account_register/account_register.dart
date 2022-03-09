import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/screen/upload/upload_docs.dart';
import 'package:devbynasirulahmed/screen/upload/upload_docs2.dart';
import 'package:devbynasirulahmed/services/date.format.dart';
import 'package:flutter/material.dart';

class AccountRegister extends StatelessWidget {
  const AccountRegister({required this.doc, Key? key});
  final Customer doc;
  //var profile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Info"),
      ),
      body: Container(
        child: Card(
          elevation: 10,
          color: Colors.blueGrey[300],
          child: ListView(
            children: [
              doc.profile == null
                  ? InkWell(
                      onTap: () {
                        print("clicked");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (___) =>
                                UploadDocs(accountNumber: doc.accountNumber),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "Upload Profile",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              doc.signature == null
                  ? InkWell(
                      onTap: () {
                        print("clicked");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (___) =>
                                UploadDocs2(accountNumber: doc.accountNumber),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "Upload Signature",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),

              optionHeader("Account Details"),
              customListTile("Account Number", doc.accountNumber),
              doc.loanAccountNumber == null || doc.loanAccountNumber == 0
                  ? SizedBox(height: 1)
                  : customListTile(
                      "Loan Account Number", doc.loanAccountNumber ?? 0),
              customListTile("Installemt", doc.installmentAmount ?? 0),
              customListTile("Principal Amount", doc.totalPrincipalAmount ?? 0),
              customListTile("Interest Amount", doc.totalInterestAmount ?? 0),
              customListTile("Maturity Amount", doc.totalMaturityAmount ?? 0),
              customListTile("Total Collection", doc.totalCollection ?? 0),
              customListTile("Maturity Date", formatDate(doc.maturityDate)),
              customListTile("Account Type", doc.accountType ?? ""),
              optionHeader("Customer Details"),

              customListTile("Name", doc.name),
              // customListTile("Address", doc.address),
              customListTile("Phone", doc.phone),
              customListTile("Father Name", doc.fatherName),

              customListTile("Age", doc.age),
              customListTile("Collector Code", doc.agentUid ?? 0),
              optionHeader("Nominee Details"),
              customListTile("Name", doc.nomineeName ?? ""),
              customListTile("Father Name", doc.nomineeFatherName ?? ""),

              // customListTile("Adress", doc.nomineeAddress ?? ""),
              customListTile("Age", doc.nomineeAge ?? 0),
              customListTile("Phone", doc.nomineePhone ?? 0),
              optionHeader("Customer Photo"),

              doc.profile == null
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          'No images',
                          style:
                              custStyle(Colors.white, FontWeight.normal, 18.0),
                        ),
                      ),
                    )
                  : Card(
                      child: Container(
                        height: 200,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: NetworkImage(doc.profile.toString()),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
              optionHeader("Customer Signature"),

              doc.signature == null
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          'No images',
                          style:
                              custStyle(Colors.white, FontWeight.normal, 18.0),
                        ),
                      ),
                    )
                  : Card(
                      child: Container(
                        height: 200,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: NetworkImage(doc.signature.toString()),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle custStyle(color, fontw, size) {
    return TextStyle(color: Colors.white, fontWeight: fontw, fontSize: size);
  }

  Widget optionHeader(text) {
    return Card(
      child: Container(
        height: 40,
        width: 200,
        color: Colors.blueGrey[600],
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              text,
              style: custStyle(Colors.white, FontWeight.bold, 16.0),
            ),
          ),
        ),
      ),
    );
  }

  ListTile customListTile(String label, dynamic data) {
    return ListTile(
      title: Text(
        label,
        style: custStyle(Colors.white, FontWeight.normal, 16.0),
      ),
      //leading: Icon(Icons.label),
      trailing: Text(
        "$data",
        style: custStyle(
          Colors.white,
          FontWeight.bold,
          16.0,
        ),
      ),
    );
  }
}
