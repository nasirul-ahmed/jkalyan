import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/screen/collection/loan_collection/loan_collection.dart';
import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';

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
          print("Money collected");
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Money collected",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pushNamedAndRemoveUntil(
              context, DashBoard.id, (route) => false);
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

  Future<void> showConfirmDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Amount: ${_amount.text}'),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                handlePress(context);
              },
              child: Text('Confirm'),
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

    Uint8List? profile = Base64Decoder().convert(widget.doc!.profile ?? '');

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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Center(
                      child: Text(
                        "Basic A/c Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 100,
              //   width: 100,
              //   child: Image( image: MemoryImage(profile))),

              // Container(
              //   width: 80,
              //   height: 80,
              //   //child: Image.memory(profile),
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     image: profile.isEmpty
              //         ? DecorationImage(
              //             image: MemoryImage(profile),
              //             fit: BoxFit.fill,
              //           )
              //         : null,
              //   ),
              // ),
              SizedBox(height: 10),
              // SizedBox(
              //   height: 10,
              // ),
              details('Name', widget.doc?.name ?? ''),
              details('Account No', widget.doc?.accountNumber),
              details('Address', widget.doc?.address),
              details('Installment', widget.doc?.installmentAmount ?? ''),
              details('Date', "${date.day}-${date.month}-${date.year}"),
              details('Principal Amount', widget.doc?.totalPrincipalAmount),
              details('Interests', widget.doc?.totalInterestAmount),
              //details('Interests', widget.doc?.),
              details('Maturity date',
                  "${maturity.day}-${maturity.month}-${maturity.year}"),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Form(
                  key: _key,
                  child: TextFormField(
                    controller: _amount,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Should not be empty!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: 'Enter Amount',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    LoanCollection(widget.doc?.accountNumber)));
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 20,
                        color: Colors.grey,
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
                    onPressed: () => showConfirmDialog(),
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
            ],
          )
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
