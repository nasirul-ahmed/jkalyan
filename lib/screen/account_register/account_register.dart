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
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Card(
            child: Container(
              height: 40,
              width: 200,
              color: Colors.grey,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text('Account Details',
                      style: custStyle(Colors.white, FontWeight.bold, 16.0)),
                ),
              ),
            ),
          ),
          customListTile("Account Number", doc!.accountNumber),
          doc!.loanAccountNumber == null || doc!.loanAccountNumber == 0
              ? SizedBox(height: 1)
              : customListTile("Loan Account Number", doc!.loanAccountNumber),
          customListTile("Installemt", doc!.installmentAmount),
          customListTile("Principal Amount", doc!.totalPrincipalAmount),
          customListTile("Interest Amount", doc!.totalInterestAmount),
          customListTile("Maturity Amount", doc!.totalMaturityAmount),
          customListTile("Total Collection", doc!.totalCollection),
          customListTile("Maturity Date", doc!.maturityDate?.split("T").first),
          customListTile("Account Type", doc!.accountType),
          Card(
            child: Container(
              height: 40,
              width: 200,
              color: Colors.grey,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text('Customer Details',
                      style: custStyle(Colors.white, FontWeight.bold, 16.0)),
                ),
              ),
            ),
          ),
          //customListTile("Account Number", doc!.accountNumber),
          customListTile("Name", doc!.name),
          customListTile("Address", doc!.address),
          customListTile("Phone", doc!.phone),

          customListTile("Age", doc!.age),
          customListTile("Collector Code", doc!.agentUid),
          Card(
            child: Container(
              height: 40,
              width: 200,
              color: Colors.grey,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text('Nominee Details',
                      style: custStyle(Colors.white, FontWeight.bold, 16.0)),
                ),
              ),
            ),
          ),
          customListTile("Name", doc!.nomineeName),

          customListTile("Adress", doc!.nomineeAddress),
          customListTile("Age", doc!.nomineeAge),
          customListTile("Phone", doc!.nomineePhone),
          Card(
            child: Container(
              height: 40,
              width: 200,
              color: Colors.grey,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Customer Photo',
                    style: custStyle(Colors.white, FontWeight.bold, 16.0),
                  ),
                ),
              ),
            ),
          ),

          doc!.profile == null
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text('No images'),
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
          Card(
            child: Container(
              height: 40,
              width: 200,
              color: Colors.grey,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Customer Signature',
                    style: custStyle(Colors.white, FontWeight.bold, 16.0),
                  ),
                ),
              ),
            ),
          ),
          doc!.signature == null
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text('No images'),
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
    );
  }

  TextStyle custStyle(color, fontw, size) {
    return TextStyle(color: color, fontWeight: fontw, fontSize: size);
  }

  ListTile customListTile(label, data) {
    return ListTile(
      title: Text('$label'),
      //leading: Icon(Icons.label),
      trailing: Text('$data'),
    );
  }
}
