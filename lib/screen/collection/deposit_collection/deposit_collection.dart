import 'dart:convert';
import 'dart:typed_data';

import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/screen/collection/deposit_collection/collection.dart';
import 'package:devbynasirulahmed/services/customer_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DepositCollection extends StatefulWidget {
  @override
  _DepositCollectionState createState() => _DepositCollectionState();
}

class _DepositCollectionState extends State<DepositCollection> {
  TextEditingController _searchAc = TextEditingController();

  String query = '';

  Future<List<Customer>> getCustomerByAc() async {
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
        return compute(parseCustomer, res.body);
      }
      return List<Customer>.empty();
    } catch (e) {
      throw e;
    }
  }

  Future<List<Customer>> getCustomer() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final url = Uri.parse('$janaklyan/api/agents/customers');

    try {
      var res = await http.post(url,
          body: jsonEncode({
            "id": _prefs.getInt('collectorId'),
          }),
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": "Bearer ${_prefs.getString('token')}"
          });
      if (200 == res.statusCode) {
        print(jsonDecode(res.body).toString());
        return compute(parseCustomer, res.body);
      }
      return List<Customer>.empty();
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
        title: Text('Deposit Collection'),
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
                  child: FutureBuilder<List<Customer>>(
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
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ListTile(
                                    hoverColor: Colors.grey[300],
                                    leading: CircleAvatar(
                                      child: Icon(
                                        Icons.person,
                                        size: 20,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              CollectionDetails(snap.data?[id]),
                                        ),
                                      );
                                    },
                                    title: Text(
                                      '${snap.data?[id].name}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    subtitle: Text(
                                      'A/c: ${snap.data?[id].accountNumber}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    trailing: Container(
                                      child: Text(
                                          '₹ ${snap.data?[id].totalPrincipalAmount}'),
                                    ),
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
                  child: FutureBuilder<List<Customer>>(
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
                                leading: CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CollectionDetails(snap.data?[id]),
                                    ),
                                  );
                                  //print(doc.id);
                                  //Navigator.pushNamed(context, CSTransaction.id);
                                },
                                title: Text(
                                  '${snap.data?[id].name}',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                subtitle: Text(
                                  'A/c: ${snap.data?[id].accountNumber}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                trailing: Container(
                                  child: Text("Balance " +
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
