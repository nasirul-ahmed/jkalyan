import 'dart:convert';
import 'dart:typed_data';

import 'package:devbynasirulahmed/models/customer.dart';
import 'package:flutter/material.dart';

class AccountRegister extends StatelessWidget {
  AccountRegister(this.doc);
  final Customer? doc;
  //var profile;
  @override
  Widget build(BuildContext context) {
    //var screen = MediaQuery.of(context).size;
    Uint8List? profile = Base64Decoder().convert(doc!.profile ?? '');
    Uint8List? signature = Base64Decoder().convert(doc!.profile ?? '');
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Info"),
      ),
      body: Card(
        elevation: 10,
        color: Colors.blueGrey[300],
        child: ListView(
          children: [
            optionHeader("Account Details"),
            customListTile("Account Number", doc!.accountNumber),
            doc!.loanAccountNumber == null || doc!.loanAccountNumber == 0
                ? SizedBox(height: 1)
                : customListTile("Loan Account Number", doc!.loanAccountNumber),
            customListTile("Installemt", doc!.installmentAmount),
            customListTile("Principal Amount", doc!.totalPrincipalAmount),
            customListTile("Interest Amount", doc!.totalInterestAmount),
            customListTile("Maturity Amount", doc!.totalMaturityAmount),
            customListTile("Total Collection", doc!.totalCollection),
            customListTile(
                "Maturity Date", doc!.maturityDate?.split("T").first),
            customListTile("Account Type", doc!.accountType),
            optionHeader("Customer Details"),
            //customListTile("Account Number", doc!.accountNumber),
            customListTile("Name", doc!.name),
            customListTile("Address", doc!.address),
            customListTile("Phone", doc!.phone),
            customListTile("Father Name", doc!.fatherName),

            customListTile("Age", doc!.age),
            customListTile("Collector Code", doc!.agentUid),
            optionHeader("Nominee Details"),
            customListTile("Name", doc!.nomineeName),
            customListTile("Father Name", doc!.nomineeFatherName),

            customListTile("Adress", doc!.nomineeAddress),
            customListTile("Age", doc!.nomineeAge),
            customListTile("Phone", doc!.nomineePhone),
            optionHeader("Customer Photo"),

            doc!.profile == null
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        'No images',
                        style: custStyle(Colors.white, FontWeight.normal, 18.0),
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
                          image: MemoryImage(profile),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
            optionHeader("Customer Signature"),

            doc!.signature == null
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        'No images',
                        style: custStyle(Colors.white, FontWeight.normal, 18.0),
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
                          image: MemoryImage(signature),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 50),
          ],
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

  ListTile customListTile(label, data) {
    return ListTile(
      title: Text(
        '$label',
        style: custStyle(Colors.white, FontWeight.normal, 16.0),
      ),
      //leading: Icon(Icons.label),
      trailing: Text(
        '$data',
        style: custStyle(
          Colors.white,
          FontWeight.bold,
          16.0,
        ),
      ),
    );
  }
}
