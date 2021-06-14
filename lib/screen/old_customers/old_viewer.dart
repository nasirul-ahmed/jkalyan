import 'dart:convert';
import 'dart:typed_data';

import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/screen/old_customers/old_full_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OldCustomerView extends StatefulWidget {
  static const id = "OldCustomerView";
  @override
  _OldCustomerViewState createState() => _OldCustomerViewState();
}

class _OldCustomerViewState extends State<OldCustomerView> {
  final _key = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  String query = "";
  // bool isDeposit = true;

  Future<List<Customer>> getInactiveCustomers() async {
    Uri uri = Uri.parse(
        'https://janakalyan-ag.herokuapp.com/api/agents/customers/inactive');
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    try {
      final res = await http.post(uri,
          body:
              jsonEncode(<String, dynamic>{"id": _prefs.getInt("collectorId")}),
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": "Bearer ${_prefs.getString('token')}"
          });

      if (200 == res.statusCode) {
        var jsonData = jsonDecode(res.body).cast<Map<String, dynamic>>();
        print(jsonData.toString());

        return jsonData
            .map<Customer>((json) => Customer.fromJson(json))
            .toList();
      } else {
        return List<Customer>.empty();
      }
    } catch (e) {
      throw Exception('Error');
    }
  }

  Future<List<Customer>> getSearchedAc() async {
    Uri uri = Uri.parse(
        'https://janakalyan-ag.herokuapp.com/api/collector//searchaccount/closed');
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    try {
      final res = await http.post(uri,
          body: jsonEncode(<String, dynamic>{
            "id": _prefs.getInt("collectorId"),
            "account": query,
          }),
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": "Bearer ${_prefs.getString('token')}"
          });

      if (200 == res.statusCode) {
        var jsonData = jsonDecode(res.body).cast<Map<String, dynamic>>();
        print(jsonData.toString());

        return jsonData
            .map<Customer>((json) => Customer.fromJson(json))
            .toList();
      } else {
        return List<Customer>.empty();
      }
    } catch (e) {
      throw Exception('Error');
    }
  }

  // @override
  // void didChangeDependencies() {
  //   _controller.addListener(() {
  //     query = _controller.text;
  //   });
  //   super.didChangeDependencies();
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      query = _controller.text;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            'Deposit List',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
      ),
      primary: true,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _key,
              child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon:
                      //query.text.trim().isNotEmpty?
                      query.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _controller.clear();
                              },
                              icon: Icon(Icons.clear),
                            )
                          : null,
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
          ),
          SizedBox(
            height: 20,
          ),
          _controller.text.isEmpty
              ? Flexible(
                  child: FutureBuilder<List<Customer>>(
                      future: getInactiveCustomers(),
                      builder: (_, snap) {
                        if (snap.hasError) {
                          return Text('');
                        }
                        if (snap.hasData) {
                          // return Text("${snap.data?.first.name}");
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snap.data?.length,
                              itemBuilder: (__, id) {
                                print(snap.data?[id].profile ?? 'y');
                                Uint8List? profile = Base64Decoder()
                                    .convert(snap.data?[id].profile ?? '');
                                return ListTile(
                                  hoverColor: Colors.grey[300],
                                  leading: snap.data?[id].profile == null
                                      ? CircleAvatar(
                                          child: Icon(Icons.person),
                                        )
                                      : Container(
                                          width: 40,
                                          height: 40,
                                          //child: Image.memory(profile),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: MemoryImage(profile),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            OldFullDetails(snap.data?[id]),
                                      ),
                                    );
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                            '₹ ${snap.data?[id].totalPrincipalAmount}'),
                                        Text(
                                          snap.data?[id].isActive == 0
                                              ? "Closed"
                                              : "Open",
                                          style: TextStyle(
                                            color: snap.data?[id].isActive == 0
                                                ? Colors.red
                                                : Colors.green,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }

                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                )
              : Flexible(
                  child: FutureBuilder<List<Customer>>(
                      future: getSearchedAc(),
                      builder: (_, snap) {
                        if (snap.hasError) {
                          return Text('');
                        }
                        if (snap.hasData) {
                          // return Text("${snap.data?.first.name}");
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snap.data?.length,
                              itemBuilder: (__, id) {
                                print(snap.data?[id].profile ?? 'y');
                                Uint8List? profile = Base64Decoder()
                                    .convert(snap.data?[id].profile ?? '');
                                return ListTile(
                                  hoverColor: Colors.grey[300],
                                  leading: snap.data?[id].profile == null
                                      ? CircleAvatar(
                                          child: Icon(Icons.person),
                                        )
                                      : Container(
                                          width: 40,
                                          height: 40,
                                          //child: Image.memory(profile),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: MemoryImage(profile),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            OldFullDetails(snap.data?[id]),
                                      ),
                                    );
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                            '₹ ${snap.data?[id].totalPrincipalAmount}'),
                                        Text(
                                          snap.data?[id].isActive == 0
                                              ? "Closed"
                                              : "Open",
                                          style: TextStyle(
                                            color: snap.data?[id].isActive == 0
                                                ? Colors.red
                                                : Colors.green,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }

                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
        ],
      ),
    );
  }
}
