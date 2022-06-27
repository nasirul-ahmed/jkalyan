import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/deposit/transfer_deposit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DepositTransferView extends StatefulWidget {
  static final id = "DepositTransferView";
  @override
  _DepositTransferViewState createState() => _DepositTransferViewState();
}

class _DepositTransferViewState extends State<DepositTransferView> {
  int? totalCollection;
  //bool isS = false;
  TextEditingController _amount = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getCollector();
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Deposit Transfer'),
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
                        'Total Deposit Balance',
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
                        totalCollection == null ? '0' : '$totalCollection',
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
            // SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0, right: 15),
            //   child: Form(
            //     key: _key,
            //     child: TextFormField(
            //       style: TextStyle(fontSize: 20),
            //       controller: _amount,
            //       validator: (v) {
            //         if (v == null || v.isEmpty) {
            //           return "Should not be empty!";
            //         }
            //         return null;
            //       },
            //       keyboardType: TextInputType.number,
            //       decoration: InputDecoration(
            //         errorStyle: TextStyle(color: Colors.black, fontSize: 10),
            //         focusedErrorBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.red, width: 2),
            //             borderRadius: BorderRadius.all(Radius.circular(30.0))),
            //         errorBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.red, width: 2),
            //             borderRadius: BorderRadius.all(Radius.circular(30.0))),
            //         focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.black, width: 2),
            //             borderRadius: BorderRadius.all(Radius.circular(30.0))),
            //         enabledBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.black, width: 2),
            //             borderRadius: BorderRadius.all(Radius.circular(30.0))),
            //         contentPadding: EdgeInsets.only(left: 10),
            //         hintText: 'Enter Amount',
            //         // focusedBorder: OutlineInputBorder(
            //         //   borderSide: BorderSide(color: Colors.grey),
            //         //   borderRadius: BorderRadius.circular(10),
            //         // ),
            //       ),
            //       textAlign: TextAlign.center,
            //       // decoration: InputDecoration(
            //       //   contentPadding: EdgeInsets.only(left: 10),
            //       //   hintText: 'Enter Recovery Amount',

            //       //   // focusedBorder: OutlineInputBorder(
            //       //   //   borderSide: BorderSide(color: Colors.grey),
            //       //   //   borderRadius: BorderRadius.circular(10),
            //       //   // ),
            //       // ),
            //     ),
            //   ),
            // ),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => TransferDeposit()));
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
            // Expanded(
            //   child: SizedBox(),
            // ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (totalCollection != 0) {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text(
                            'Do you want to proceed?',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          content: Text(
                            'Amount : $totalCollection',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                if (totalCollection != 0 ||
                                    totalCollection != null) {
                                  await sendMoney(totalCollection!);
                                  //int.parse(_amount.text).abs()
                                }
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

  Future<void> successDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          content: SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.checkCircle),
                SizedBox(
                  height: 10,
                ),
                Text('Success'),
              ],
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            )
          ],
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
      },
    );
  }

  Future<void> sendMoney(int amount) async {
    Navigator.pop(context);
    showLoadingDialog();
    DateTime date = DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt('collectorId');

    Uri url = Uri.parse("$janaklyan/api/collector/create/deposit/tnx");

    try {
      print(token);
      print(id);
      var res = await http.post(
        url,
        body: jsonEncode(<String, dynamic>{
          "amount": amount,
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
        successDialog();
      } else {
        Navigator.pop(context);
        showErrorDialog();
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
          totalCollection = jsonData[0]['totalCollection'] ?? 0;
        });
      } else {
        return;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
