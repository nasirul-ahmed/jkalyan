import 'dart:async';
import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Maturity extends StatefulWidget {
  Maturity(this.doc);
  final Customer? doc;
  @override
  _MaturityState createState() => _MaturityState();
}

class _MaturityState extends State<Maturity> {
  Future<void> sendData() async {
    showLoadingDialog(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt('collectorId');

    Uri url = Uri.parse("$janaklyan/api/collector/maturity-ac");

    try {
      print(token);
      print(id);
      var res = await http.post(
        url,
        body: jsonEncode(<String, dynamic>{
          "accountNumber": widget.doc!.accountNumber,
          "cust_name": widget.doc!.name,
          "collectorId": id,
          "principalAmount": widget.doc!.totalPrincipalAmount,
          "maturityInterest": widget.doc!.totalMaturityAmount,
          "totalCollection": widget.doc!.totalCollection,
        }),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );

      if (200 == res.statusCode) {
        Navigator.pop(context);
        var jsonData = jsonDecode(res.body);
        print(jsonData);
        successDialog(context);
      } else {
        Navigator.pop(context);
        showErrorDialog(context);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maturity'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Text(
              'Basic A/c Details',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          details('Account Number', "${widget.doc?.accountNumber}"),
          details('Name', "${widget.doc?.name}"),
          details('Interest Amount', "${widget.doc?.totalInterestAmount}"),
          details('Principal Amount', "${widget.doc?.totalPrincipalAmount}"),
          details('Maturity Amount', "${widget.doc?.totalMaturityAmount}"),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.circular(30.0),
              ),
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                onPressed: () => conFirm(),
                child: Text(
                  'Request To Mature this Account',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> conFirm() {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            actions: [
              MaterialButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  sendData();
                },
              ),
            ],
            title: Text(
              'Do you want to proceed?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: Text('To mature A/c: ${widget.doc?.accountNumber}'),
          );
        });
  }

  Widget details(string, name) {
    var screen = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 45,
        width: screen.width - 20,
        child: Card(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        //height: 37,
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$string',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.cyan[700],
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
