import 'dart:convert';
import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';
import 'package:devbynasirulahmed/screen/passbook/loan_passbook/loan_passbook.dart';
import 'package:devbynasirulahmed/screen/repayment_history/repayment_history.dart';
import 'package:devbynasirulahmed/widgets/success_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/loan_customer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanCollection extends StatelessWidget {
  LoanCollection(this.doc);
  final LoanCustomer? doc;
  final _key = GlobalKey<FormState>();
  TextEditingController _amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Recovery"),
      ),
      body: SingleChildScrollView(
        child: Column(
          //shrinkWrap: true,
          children: [
            SizedBox(
              height: 10,
            ),
            // details("string", name)

            ListView(
              shrinkWrap: true,
              children: [
                Card(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      details("Name", doc!.custName),
                      details("Loan Account", doc!.loanAcNo),
                      details("Loan Amount", doc?.loanAmount),
                      details("Created At", doc!.createdAt?.split('T').first),
                      details("Last update", doc!.updatedAt?.split('T').first),
                      details("Interest Rate", doc!.interestRate),
                      //Todo:
                      details("Remaining Interest", doc!.loanInterest),
                      details("Collection Amount", doc!.totalCollection),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Form(
                    key: _key,
                    child: TextFormField(
                      style: TextStyle(fontSize: 20),
                      controller: _amount,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Should not be empty!";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorStyle:
                            TextStyle(color: Colors.black, fontSize: 10),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        contentPadding: EdgeInsets.only(left: 10),
                        hintText: 'Enter Amount',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30.0)),
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          showConfirmDialog(context);
                        }
                      },
                      child: Text(
                        'Collect',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          // color: Colors.green,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: InkWell(
                        enableFeedback: true,
                        onTap: () {
                          print("object");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LoanPassbook(doc)));
                        },
                        highlightColor: Colors.brown,
                        hoverColor: Colors.amber,
                        splashColor: Colors.amber,
                        child: Center(
                          child: Text(
                            "Passbook",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          // color: Colors.green,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: InkWell(
                        enableFeedback: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    RepaymentHistory(loanAcNo: doc!.loanAcNo, name: doc!.custName)),
                          );
                        },
                        highlightColor: Colors.brown,
                        hoverColor: Colors.amber,
                        splashColor: Colors.amber,
                        child: Center(
                          child: Text(
                            "Repayment History",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> collectLoan(BuildContext context) async {
    showLoadingDialog(context);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String uri = '$janaklyan/api/collector/loan/collection';

    DateTime x = DateTime.now();
    final res = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer ${_prefs.getString('token')}"
      },
      body: jsonEncode(<String, dynamic>{
        "collectorId": _prefs.getInt('collectorId'),
        "loanAcNo": doc!.loanAcNo,
        "amount": (int.parse(_amount.text)).abs(),
        "createdAt": DateTime.now().toString().split(' ')[0]
      }),
    );

    if (res.statusCode == 200) {
      var parsed = jsonDecode(res.body);
      Navigator.pop(context);
      print(res.body.toString());
      //var jsonData = jsonDecode(response.body);
      //Navigator.push(context, MaterialPageRoute(builder: (_) => DashBoard()));
      Fluttertoast.showToast(msg: "Collected");
      successCollectionDialog(parsed['insertId'], context);
    } else {
      print(res.statusCode);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error");
      throw Exception('wrong');
    }
  }

  Future<void> successCollectionDialog(int? tnxId, BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.green,
          title: Text(
            'Money Collected.',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Transaction Id: $tnxId',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => DashBoard()));
              },
              child: Container(
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(25)),
                child: Text(
                  '  ok  ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> showConfirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'Are you sure?',
            style: TextStyle(color: Colors.green),
          ),
          content: Text(
            'Amount: ${_amount.text}',
            style: TextStyle(color: Colors.green),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                collectLoan(context);
              },
              child: Container(
                  margin: EdgeInsets.only(right: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        );
      },
    );
  }

  Widget details(string, name) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 45,
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
                          child: Text('$string')),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
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
