import 'dart:convert';
import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';
import 'package:devbynasirulahmed/widgets/success_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/loan_customer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanCollection extends StatelessWidget {
  LoanCollection(this.customerAccount);
  final int? customerAccount;
  final _key = GlobalKey<FormState>();
  TextEditingController _amount = TextEditingController();
  Future<LoanCustomer> getLoanCustomer() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String uri = '$janaklyan/api/collector/loan/customer';
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer ${_prefs.getString('token')}"
      },
      body: jsonEncode(<String, dynamic>{
        "id": _prefs.getInt('collectorId'),
        "depositAc": customerAccount
      }),
    );

    if (response.statusCode == 200) {
      print('success added' + response.body.toString());
      var jsonData = jsonDecode(response.body);
      return LoanCustomer.fromJson(jsonData);
    } else {
      print(response.statusCode);
      throw Exception('wrong');
    }
  }

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
            FutureBuilder<LoanCustomer>(
                future: getLoanCustomer(),
                builder: (_, snap) {
                  if (snap.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        details("Name", snap.data!.custName),
                        details("Loan Account", snap.data!.loanAcNo),
                        details("Loan Amount", snap.data!.loanAmount),
                        details("Interest Amount", snap.data!.loanInterest),
                        details("Created At",
                            snap.data!.createdAt?.split('T').first),
                        details("Last update",
                            snap.data!.createdAt?.split('T').first),
                        details(
                            "Collection Amount", snap.data!.totalCollection),
                        SizedBox(
                          height: 10,
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
                                hintText: 'Enter Recovery Amount',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
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
                              onPressed: () => showConfirmDialog(context),
                              child: Text(
                                'Collect',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  } else if (snap.hasError) {
                    return Center(
                      child: Text('Something\'s wrong'),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
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
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": "Bearer ${_prefs.getString('token')}"
      },
      body: jsonEncode(<String, dynamic>{
        "collectorId": _prefs.getInt('collectorId'),
        "depositAcNo": customerAccount,
        //"loanAcNo": customerAccount,
        "amount": (int.parse(_amount.text)).abs(),
        "createdAt": "${x.year}-${x.month}-${x.day}"
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
      print(response.body.toString());
      //var jsonData = jsonDecode(response.body);
      Navigator.push(context, MaterialPageRoute(builder: (_) => DashBoard()));
      Fluttertoast.showToast(msg: "Collected");
    } else {
      print(response.statusCode);
      throw Exception('wrong');
    }
  }

  Future<void> showConfirmDialog(BuildContext context) {
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
                collectLoan(context);
              },
              child: Text('Confirm'),
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
