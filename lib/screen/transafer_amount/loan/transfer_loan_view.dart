import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/deposit_tnx.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/loan/transfer_loan.dart';
import 'package:devbynasirulahmed/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransferLoanView extends StatefulWidget {
  static final id = "TransferLoanView";
  @override
  _TransferLoanViewState createState() => _TransferLoanViewState();
}

class _TransferLoanViewState extends State<TransferLoanView> {
  num? totalLoanCollection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCollector();
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Loan Transfer'),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                elevation: 16,
                child: Container(
                  height: 200,
                  width: screen.width,
                  decoration: BoxDecoration(color: Colors.orange[800]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total Loan Balance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        totalLoanCollection == null
                            ? "0"
                            : '$totalLoanCollection',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    'note: You can\'t undo once money is send',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TransferLoan()));
              },
              child: Container(
                height: 50,
                width: screen.width - 40,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Payment Status and History',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (totalLoanCollection != 0) {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text('Do you want to proceed?'),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            MaterialButton(
                              onPressed: () {
                                sendMoney();
                              },
                              child: Text('Procced'),
                            )
                          ],
                        );
                      });
                } else {
                  return null;
                }
              },
              child: Container(
                height: 50,
                width: screen.width - 40,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Send',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendMoney() async {
    Navigator.pop(context);
    showLoadingDialog(context);
    DateTime date = DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt('collectorId');

    Uri url = Uri.parse("$janaklyan/api/collector/create/loan-deposits/tnx");

    try {
      print(token);
      print(id);
      var res = await http.post(
        url,
        body: jsonEncode(<String, dynamic>{
          "collectorId": id,
          "date": "${date.year}-${date.month}-${date.day}"
        }),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );

      if (200 == res.statusCode) {
        var jsonData = jsonDecode(res.body);
        Navigator.pop(context);
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

  Future<void> getCollector() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt('collectorId');

    Uri url = Uri.parse("$janaklyan/api/collector/get-collector-by-id");

    try {
      print(token);
      print(id);
      var res = await http.post(
        url,
        body: jsonEncode(<String, dynamic>{"id": id}),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );

      if (200 == res.statusCode) {
        var jsonData = jsonDecode(res.body);
        print(jsonData);
        setState(() {
          totalLoanCollection = jsonData[0]['totalLoanCollection'] ?? 0;
        });
      } else {
        return;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
