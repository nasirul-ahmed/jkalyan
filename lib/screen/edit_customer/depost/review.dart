import 'dart:convert';

import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Review extends StatelessWidget {
  Review(
    this.accountNumber,
    this.accountType,
    this.maturityDate,
    this.totalInstallments,
    this.totalPrincipalAmount,
    this.totalInterestAmount,
    this.totalMaturityAmount,
    this.rateOfInterest,
    this.installmentAmount,
  );
  final accountNumber;
  final accountType;
  final maturityDate;
  final totalInstallments;
  final totalPrincipalAmount;
  final totalInterestAmount;
  final totalMaturityAmount;
  final rateOfInterest;
  final installmentAmount;

  handlePress(BuildContext context) async {
    showLoadingDialog(context);
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    Uri uri = Uri.parse(
        'https://sanchay-new.herokuapp.com/api/collector/edit/customer');

    var body = jsonEncode(<String, dynamic>{
      "accountNumber": accountNumber,
      "accountType": accountType,
      "maturityDate": maturityDate,
      "totalInstallments": totalInstallments,
      "totalPrincipalAmount": totalPrincipalAmount,
      "totalInterestAmount": totalInterestAmount,
      "totalMaturityAmount": totalMaturityAmount,
      "rateOfInterest": int.parse(rateOfInterest),
      "installmentAmount": int.parse(installmentAmount),
      "collectorId": _prefs.getInt("collectorId")
    });
    try {
      var res = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': "*/*",
            "Authorization": "Bearer ${_prefs.getString('token')}",
          },
          body: body);

      if (200 == res.statusCode) {
        print('success');
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, DashBoard.id, (route) => false);
      } else {
        Navigator.pop(context);
        showErrorDialog(context);
        print(res.statusCode);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    print(accountNumber);
    return Scaffold(
      appBar: AppBar(
        title: Text('Review'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          details("Account Number", accountNumber),
          details("Rate of Interest", rateOfInterest),
          details("Installment Amount", installmentAmount),
          details("Account Type", accountType),
          details("Maturity Date", maturityDate),
          details("Installments", totalInstallments),
          details('Principal Amount', totalPrincipalAmount),
          details('Interest Amount', totalInterestAmount),
          details('Maturity Amount', totalMaturityAmount),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () => handlePress(context),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w700,
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
    );
  }

  Future<void> showErrorDialog(BuildContext context) {
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

  Future<void> showLoadingDialog(BuildContext context) {
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
