import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/models/loan_customer.dart';
import 'package:devbynasirulahmed/screen/passbook/loan_passbook/loan_passbook.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoanPassBookSearch extends StatefulWidget {
  @override
  _LoanPassBookSearchState createState() => _LoanPassBookSearchState();
}

class _LoanPassBookSearchState extends State<LoanPassBookSearch> {
  TextEditingController _searchAc = TextEditingController();
  //String query = '';

  bool isEmpty = true;

  bool checkInput(String? x) {
    if (x == null || x.isEmpty) {
      return false;
    }

    final number = num.tryParse(x);

    if (number == null)
      return false;
    else
      return true;
  }

  @override
  void initState() {
    super.initState();
    _searchAc.addListener(() {
      setState(() {
        isEmpty = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchAc.dispose();
  }

  Future<List<LoanCustomer>> getLoanCustomerByAc(bool x) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final url;

    if (x) {
      url = Uri.parse('$janaklyan/api/collector/search-loan-account');
    } else {
      url = Uri.parse('$janaklyan/api/collector/search-loanac-by-name');
    }

    var body = jsonEncode({
      "account": _searchAc.text,
      "name": _searchAc.text,
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
        var parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();

        return parsed
            .map<LoanCustomer>((json) => LoanCustomer.fromJson(json))
            .toList();
      }
      return List<LoanCustomer>.empty();
    } catch (e) {
      throw e;
    }
  }

  Future<List<LoanCustomer>> getLoanCustomer() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final url = Uri.parse('$janaklyan/api/collector/loan-customers');

    try {
      var res = await http.post(url,
          body: jsonEncode({
            "collectorId": _prefs.getInt('collectorId'),
          }),
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": "Bearer ${_prefs.getString('token')}"
          });
      if (200 == res.statusCode) {
        var parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();

        return parsed
            .map<LoanCustomer>((json) => LoanCustomer.fromJson(json))
            .toList();
      }
      return List<LoanCustomer>.empty();
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Account'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: TextField(
              controller: _searchAc,
              keyboardType: TextInputType.text,
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
                hintText: 'Enter a customer name',
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
          SizedBox(
            height: 10,
          ),
          searchLoanCustomer(),
        ],
      ),
    );
  }

  Widget searchLoanCustomer() {
    var futureBuilder = FutureBuilder<List<LoanCustomer>>(
        future: checkInput(_searchAc.text)
            ? getLoanCustomerByAc(true)
            : getLoanCustomerByAc(false),
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
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      onTap: () {
                        //widget.callback3(snap.data?[id]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => LoanPassbook(snap.data?[id])));
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
                        child: Text('₹ ${snap.data?[id].totalCollection}'),
                      ));
                });
          } else
            return Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                backgroundColor: Colors.pink,
              ),
            );
        });
    return _searchAc.text.isEmpty
        ? Flexible(
            child: FutureBuilder<List<LoanCustomer>>(
              future: getLoanCustomer(),
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
                              //widget.callback3(snap.data?[id]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          LoanPassbook(snap.data?[id])));
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
                              child:
                                  Text('₹ ${snap.data?[id].totalCollection}'),
                            ));
                      });
                } else {
                  return SizedBox(
                    //alignment: Alignment.center,
                    //width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.4,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          )
        : Flexible(child: futureBuilder);
  }
}
