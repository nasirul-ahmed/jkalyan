import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApplyLoan extends StatefulWidget {
  static const id = 'ApplyLoan';

  @override
  _ApplyLoanState createState() => _ApplyLoanState();
}

class _ApplyLoanState extends State<ApplyLoan> {
  final _key = GlobalKey<FormState>();

  TextEditingController _amount = TextEditingController();

  TextEditingController _accountNumber = TextEditingController();
  TextEditingController _custName = TextEditingController();

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
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: screen.width - 40,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Fill the form',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: textField(
                  _accountNumber, 'Account No.', TextInputType.number),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20, bottom: 20.0),
              child: textField(_custName, 'Customer Name', TextInputType.text),
            ),
            SizedBox(
              height: 10,
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
            Expanded(
              child: SizedBox(),
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
                    'Submit',
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
    //"Authorization": "Bearer $token"
    // DateTime x = DateTime.now();
    print(_prefs.getInt("collectorId"));
    var body = jsonEncode(<String, dynamic>{
      "collectorId": _prefs.getInt('collectorId'),
      "depositAcNo": _accountNumber.text,
      "loanAmount": _amount.text,
      "createdAt": DateTime.now().toString().split(" ")[0],
      "custName": _custName.text
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
                  Navigator.pop(context);
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, DashBoard.id, (route) => false);
                  applyLoan();
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
