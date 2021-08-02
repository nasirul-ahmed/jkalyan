import 'dart:convert';
import 'dart:typed_data';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/screen/maturity/maturity.dart';
import 'package:http/http.dart' as http;
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaturityView extends StatefulWidget {
  @override
  _MaturityViewState createState() => _MaturityViewState();
}

class _MaturityViewState extends State<MaturityView> {
  TextEditingController _searchAc = TextEditingController();

  String query = '';

  Future<List<Customer>> getCustomerByAc() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final url = Uri.parse('$janaklyan/api/collector/search-ac-by-name');

    var body = jsonEncode({
      "name": query,
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

        return parsed.map<Customer>((json) => Customer.fromJson(json)).toList();
        //return compute(parseCustomer, res.body);
      }
      return List<Customer>.empty();
    } catch (e) {
      throw Exception(e);
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
        final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();

        return parsed.map<Customer>((json) => Customer.fromJson(json)).toList();
        //return compute(parseCustomer, res.body);
      }
      return List<Customer>.empty();
    } catch (e) {
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
        title: Text('Maturity/Pre Maturity'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                                      // if (widget.isMaturity) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              Maturity(snap.data?[id]),
                                        ),
                                      );
                                      // } else {
                                      //   Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (_) =>
                                      //           PreMaturity(snap.data?[id]),
                                      //     ),
                                      //   );
                                      // }
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
                                      child: Text(
                                          '₹ ${snap.data?[id].totalPrincipalAmount}'),
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
                                    //if (widget.isMaturity) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            Maturity(snap.data?[id]),
                                      ),
                                    );
                                    // } else {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (_) =>
                                    //           PreMaturity(snap.data?[id]),
                                    //     ),
                                    //   );
                                    // }
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
                                    child: Text(
                                        '₹ ${snap.data?[id].totalPrincipalAmount}'),
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
      ),
    );
  }
}
