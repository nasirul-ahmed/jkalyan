import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/screen/apply_loan/apply_loan.dart';
import 'package:devbynasirulahmed/screen/collection/loan_collection/loan_collection.dart';
import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';
import 'package:devbynasirulahmed/screen/loan_applications/loan_applications.dart';
import 'package:devbynasirulahmed/screen/passbook/passbook_customer.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CollectionDetails extends StatefulWidget {
  final Customer? doc;
  CollectionDetails(this.doc);
  static String id = 'CollectionDetails';

  @override
  _CollectionDetailsState createState() => _CollectionDetailsState();
}

class _CollectionDetailsState extends State<CollectionDetails> {
  final _key = GlobalKey<FormState>();
  TextEditingController _amount = TextEditingController();

  bool err = false;
  DateTime getDate = DateTime.now();

  Future handlePress(ctx) async {
    if (_key.currentState!.validate()) {
      if (!err) {
        showLoadingDialog();
      } else {
        showErrorDialog();
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? collectorId = prefs.getInt('collectorId');
      // print(prefs.getInt('collectorId').toString());
      // print(_amount.text);
      String url = "$janaklyan/api/collector/deposit-collection";

      //SharedPreferences _prefs = await SharedPreferences.getInstance();

      final body = jsonEncode(<String, dynamic>{
        "amount": (int.parse(_amount.text)).abs(),
        "collectorId": collectorId,
        "accountNumber": widget.doc?.accountNumber,
        "id": prefs.getInt('collectorId'),
        "date": "${getDate.year}-${getDate.month}-${getDate.day}"
      });

      try {
        var res = await http.post(
          Uri.parse(url),
          body: body,
          headers: {
            'Content-Type': 'application/json',
            'Accept': "*/*",
            "Authorization": "Bearer ${prefs.getString('token')}",
          },
        );

        if (200 == res.statusCode) {
          Navigator.pop(context);
          var parsed = jsonDecode(res.body);
          print(parsed['insertId'].toString());
          print("Money collected");

          // Fluttertoast.showToast(
          //     msg: "Money collected",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
          successCollectionDialog(parsed['insertId']);
        } else {
          Navigator.pop(context);
          showErrorDialog();
          print(res.statusCode);
          setState(() {
            err = true;
          });
        }
      } catch (e) {
        print(e);
        setState(() {
          err = true;
        });
      }
    }
  }

  Future<void> successCollectionDialog(int? tnxId) {
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
                Navigator.pushNamedAndRemoveUntil(
                    context, DashBoard.id, (route) => false);
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

  Future<void> showConfirmDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.green,
          title: Text(
            'Are you sure?',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Amount: ${_amount.text}',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                handlePress(context);
              },
              child: Container(
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(25)),
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> showLoadingDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          content: SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Loading...'),
                SizedBox(
                  height: 30,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  strokeWidth: 5.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showErrorDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
              title: Text('Error'),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                )
              ],
              content: Text('Something wrong'));
        });
  }

  @override
  Widget build(BuildContext context) {
    DateTime? date;
    date = DateTime.parse(widget.doc!.createdAt!);

    DateTime maturity = DateTime.parse(widget.doc!.maturityDate!);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Colletion'),
        backgroundColor: Colors.orange[600],
      ),
      body: ListView(
        //physics: ScrollPhysics.,
        shrinkWrap: true,
        children: [
          Column(
            children: [
              SizedBox(height: 10),
              Card(
                color: Colors.green,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    details('Name', widget.doc?.name ?? ''),
                    details('Account No', widget.doc?.accountNumber),
                    //details('Address', widget.doc?.address),

                    //details('Date', "${date.day}-${date.month}-${date.year}"),
                    details(
                        'Principal Amount', widget.doc?.totalPrincipalAmount),
                    details('Interests', widget.doc?.totalInterestAmount),
                    //details('Interests', widget.doc?.),
                    details('Opening date',
                        "${widget.doc?.createdAt.toString().split("T")[0]}"),
                    details('Maturity date',
                        "${widget.doc?.maturityDate.toString().split("T")[0]}"),
                    details('Installment', widget.doc?.installmentAmount ?? ''),
                    details(
                        'Collected Balance', "${widget.doc?.totalCollection}"),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
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
                      errorStyle: TextStyle(color: Colors.black, fontSize: 10),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2),
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: 'Enter Amount',
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.grey),
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
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
                  //width: MediaQuery.of(context).size.width - 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30.0)),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MaterialButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        showConfirmDialog();
                      }
                    },
                    child: Text(
                      'Collect',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              widget.doc?.loanAccountNumber == 0 ||
                      widget.doc?.loanAccountNumber == null
                  ? Container()
                  : InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) =>
                        //             LoanCollection(widget.doc)));
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.green,
                        ),
                        child: InkWell(
                          child: Center(
                            child: Text(
                              "Loan Details Page",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.doc?.loanAccountNumber == 0
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ApplyLoan(cust: widget.doc,),
                          ),
                        );
                      },
                      child: Center(
                          child: Center(
                        child: Text(
                          "Apply Loan",
                          style: TextStyle(color: Colors.green, fontSize: 16),
                        ),
                      )),
                    )
                  : Container(),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PassbookCustomer(widget.doc)));
                },
                child: Center(
                    child: Center(
                  child: Text(
                    "See Passbook",
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                )),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget details(string, name) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 45,
        child: Card(
          elevation: 5,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.green,
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
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
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
