import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/loan_application_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LoanApplications extends StatefulWidget {
  const LoanApplications({Key? key}) : super(key: key);

  @override
  _LoanApplicationsState createState() => _LoanApplicationsState();
}

class _LoanApplicationsState extends State<LoanApplications> {
  int deleted = 0;
  bool defaultPage = true;

  //loan-applications Pending
  Future<List<LoanApplicationModel>> getPendingApplicationList() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse("$janaklyan/api/collector/loan-applications");

    var body = jsonEncode(<String, dynamic>{
      "collectorId": _prefs.getInt('collectorId'),
    });

    try {
      var res = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        "Authorization": "Bearer ${_prefs.getString('token')}",
      });
      if (200 == res.statusCode) {
        // return compute(parseTransactions, res.body);
        final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();

        return parsed
            .map<LoanApplicationModel>(
                (json) => LoanApplicationModel.fromJson(json))
            .toList();
      }

      return List<LoanApplicationModel>.empty();
    } catch (e) {
      throw Exception(e);
    }
  }

  //approved-loan-applications

  Future<List<LoanApplicationModel>> getSuccessApplicationList() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse("$janaklyan/api/collector/approved-loan-applications");

    var body = jsonEncode(<String, dynamic>{
      "collectorId": _prefs.getInt('collectorId'),
    });

    try {
      var res = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        "Authorization": "Bearer ${_prefs.getString('token')}",
      });
      if (200 == res.statusCode) {
        // return compute(parseTransactions, res.body);
        final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();

        return parsed
            .map<LoanApplicationModel>(
                (json) => LoanApplicationModel.fromJson(json))
            .toList();
      }

      return List<LoanApplicationModel>.empty();
    } catch (e) {
      throw Exception(e);
    }
  }

  //delete-loan-application
  Future<void> deleteApplication(
      BuildContext context, int applicationId) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse("$janaklyan/api/collector/delete-loan-application");

    var body = jsonEncode(<String, dynamic>{
      "collectorId": _prefs.getInt('collectorId'),
      "applicationId": applicationId
    });

    try {
      var res = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        "Authorization": "Bearer ${_prefs.getString('token')}",
      });
      if (200 == res.statusCode) {
        // return compute(parseTransactions, res.body);
        final parsed = jsonDecode(res.body);
        print(parsed.toString());
        Fluttertoast.showToast(
            msg: "Application deleted",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);

        setState(() {
          deleted = deleted + 1;
        });
        //Navigator.p
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => LoanApplications()));

      } else {
        print(res.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              defaultPage == true ? Colors.amber[900] : Colors.pink[900],
          title: Text(defaultPage == true ? "Pending List" : "Approved List"),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  defaultPage = !defaultPage;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Center(
                  child: Text(
                    defaultPage == false ? "Pending List" : 'Approved List',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.3,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: defaultPage == true
            ? FutureBuilder<List<LoanApplicationModel>>(
                future: getPendingApplicationList(),
                builder: (__, snap) {
                  if (snap.hasError)
                    return Center(
                      child: Text(
                        snap.error.toString(),
                      ),
                    );
                  if (snap.hasData) {
                    return ListView.builder(
                        itemCount: snap.data?.length,
                        itemBuilder: (___, indx) {
                          return customView(snap.data![indx], context);
                        });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })
            : FutureBuilder<List<LoanApplicationModel>>(
                future: getSuccessApplicationList(),
                builder: (__, snap) {
                  if (snap.hasError)
                    return Center(
                      child: Text(
                        snap.error.toString(),
                      ),
                    );
                  if (snap.hasData) {
                    return ListView.builder(
                        itemCount: snap.data?.length,
                        itemBuilder: (___, indx) {
                          return customView2(snap.data![indx], context);
                        });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }));
  }

  Widget customView2(LoanApplicationModel doc, BuildContext context) {
    final input = new DateFormat('yyyy-MM-dd');
    final output = new DateFormat('dd-MM-yyyy');
    final date = input.parse(doc.processDate.toString().split("T")[0]);
    final finalDate = output.format(date);
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Card(
        child: Container(
          color: Colors.grey[300],
          height: 100,
          width: MediaQuery.of(context).size.width - 20,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Loan Amount: " + doc.loanAmount.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Deposit A/c : " + doc.depositAcNo.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        //color: Colors.amber,
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
                                    text: "Name : " + doc.custName.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                //child: Text(name.toString())),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Loan Date : " + "$finalDate",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
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

              //SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget customView(LoanApplicationModel doc, BuildContext context) {
    //DateTime date = DateTime.parse(doc.date);
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: Container(
          color: Colors.grey[300],
          height: 130,
          width: MediaQuery.of(context).size.width - 20,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Loan Amount: " + doc.loanAmount.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Deposit A/c : " + doc.depositAcNo.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        //color: Colors.amber,
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
                                    text: "Name : " + doc.custName.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                //child: Text(name.toString())),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Date : " + "${doc.isProcessing}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
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
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    print(doc.id.toString());
                    deleteApplication(context, doc.id!);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 30,
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          'Delete This Application',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
