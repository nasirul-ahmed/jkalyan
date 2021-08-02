import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/loan_customer.dart';
import 'package:devbynasirulahmed/screen/collection/loan_collection/loan_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoanCollectionView extends StatefulWidget {
  @override
  _LoanCollectionViewState createState() => _LoanCollectionViewState();
}

class _LoanCollectionViewState extends State<LoanCollectionView> {
  TextEditingController _searchAc = TextEditingController();

  String query = '';

  Future<List<LoanCustomer>> getCustomerByAc() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final url = Uri.parse('$janaklyan/api/collector/searchaccount');

    var body = jsonEncode({
      "account": query,
      "id": _prefs.getInt('collectorId'),
    });

    try {
      var res = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": "Bearer ${_prefs.getString('token')}"
          },
          body: body);
      if (200 == res.statusCode) {
        print(res.body.toString());
        final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();

        return parsed
            .map<LoanCustomer>((json) => LoanCustomer.fromJson(json))
            .toList();
      }
      return List<LoanCustomer>.empty();
    } catch (e) {
      throw e;
    }
  }

  Future<List<LoanCustomer>> getCustomer() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final url = Uri.parse('$janaklyan/api/collector/loan/customer');

    try {
      var res = await http.post(url,
          body: jsonEncode(<String, dynamic>{
            "collectorId": _prefs.getInt('collectorId'),
          }),
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": "Bearer ${_prefs.getString('token')}"
          });
      if (200 == res.statusCode) {
        print(jsonDecode(res.body).toString());
        final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();

        return parsed
            .map<LoanCustomer>((json) => LoanCustomer.fromJson(json))
            .toList();
      }
      return List<LoanCustomer>.empty();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  void initState() {
    _searchAc.addListener(() {
      //here you have the changes of your textfield
      print("value: ${_searchAc.text}");
      //use setState to rebuild the widget
      setState(() {
        query = _searchAc.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text('Loan Collection'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchAc,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixIcon:
                    //query.text.trim().isNotEmpty?
                    IconButton(
                  onPressed: () {
                    _searchAc.clear();
                  },
                  icon: Icon(Icons.clear),
                ),
                //: null,
                hintText: 'Enter a account number',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    //Color(0xff016b1d),
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          _searchAc.text.isEmpty
              ? Flexible(
                  child: FutureBuilder<List<LoanCustomer>>(
                      future: getCustomer(),
                      builder: (_, snap) {
                        if (snap.hasError) {
                          print(snap.error.toString());
                          return Center(
                            child: Text("Something went wrong"),
                          );
                        } else if (snap.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snap.data?.length,
                              itemBuilder: (__, id) {
                                return ListTile(
                                  hoverColor: Colors.grey[300],
                                  leading: Text(''),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            LoanCollection(snap.data?[id]),
                                      ),
                                    );
                                  },
                                  title: Text(
                                    '${snap.data?[id].custName}',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  subtitle: Text(
                                    'A/c: ${snap.data?[id].loanAcNo}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  trailing: Container(
                                    child: Text(
                                        '₹ ${snap.data?[id].totalCollection}'),
                                  ),
                                );
                              });
                        } else
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.pink,
                            ),
                          );
                      }),
                )
              : Flexible(
                  child: FutureBuilder<List<LoanCustomer>>(
                    future: getCustomerByAc(),
                    builder: (_, snap) {
                      if (snap.hasError) {
                        print(snap.error);
                        return Text('Something Wrong');
                      } else if (snap.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snap.data?.length,
                            itemBuilder: (__, id) {
                              return ListTile(
                                hoverColor: Colors.grey[300],
                                leading: Text(''),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          LoanCollection(snap.data?[id]),
                                    ),
                                  );
                                },
                                title: Text(
                                  '${snap.data?[id].custName}',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                subtitle: Text(
                                  'Loan A/c: ${snap.data?[id].loanAcNo}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                trailing: Container(
                                  child: Text("Recovery Balance " +
                                      '₹ ${snap.data?[id].totalCollection}'),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
        ],
      ),
    );
  }
}
