import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApplyLoan extends StatefulWidget {
  static const id = 'ApplyLoan';
  final Customer? cust;

  ApplyLoan({Key? key, this.cust}) : super(key: key);

  @override
  _ApplyLoanState createState() => _ApplyLoanState();
}

class _ApplyLoanState extends State<ApplyLoan> {
  final _key = GlobalKey<FormState>();

  TextEditingController _amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Apply Loan'),
      ),
      body: Form(
        key: _key,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                padding: EdgeInsets.all(10),
                child: Card(
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Cutomer Name : ${widget.cust!.name}",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Container(
                          child: Text(
                              "Deposit Ac : ${widget.cust!.accountNumber}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20, bottom: 20.0),
              child: textField(_amount, 'Amount', TextInputType.number),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Opacity(
                  opacity: .7,
                  child: Text(
                    'note: Please enter the seeking loan amount ',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (_key.currentState!.validate()) {
                  applyLoan();
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
                  child: Text(
                    'Apply Loan',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> applyLoan() async {
    showLoadingDialog(context);
    final url = Uri.parse('$janaklyan/api/collector/apply-loan');

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString('token');
    print(_prefs.getInt("collectorId"));
    var body = jsonEncode(<String, dynamic>{
      "collectorId": _prefs.getInt('collectorId'),
      "depositAcNo": widget.cust!.accountNumber,
      "loanAmount": _amount.text,
      "createdAt": DateTime.now().toString(),
      "custName": widget.cust!.name
    });
    try {
      var res = await http.post(
        url,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (200 == res.statusCode) {
        print(res.statusCode);
        Navigator.pop(context);

        successDialog(context);
      } else {
        Navigator.pop(context);
        showErrorDialog(context);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> showD(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Do you want to apply?'),
            elevation: 16,
            // content: Text('Account Number: '),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30,
                  width: 80,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  applyLoan();
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30,
                  width: 80,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          );
        });
  }

  Widget textField(_amount, _label, TextInputType type) {
    return Container(
      height: 70,
      child: TextFormField(
        controller: _amount,
        validator: (v) {
          if (v == null || v.isEmpty) {
            return "Please enter valid characters";
          }
          return null;
        },
        keyboardType: type,
        decoration: InputDecoration(
          labelText: _label,
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white, width: 2, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
