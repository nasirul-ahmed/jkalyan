import 'dart:convert';

import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/commssion_model.dart';
import 'package:devbynasirulahmed/services/date.format.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CommissionView extends StatefulWidget {
  static const String id = "Commission";
  @override
  _CommissionViewState createState() => _CommissionViewState();
}

class _CommissionViewState extends State<CommissionView> {
  num commission = 0;
  num totalCollection = 0;
  bool isLoading = false;
  num allTimeCommission = 0;
  num allTimeDeposits = 0;
  num commissionPaid = 0;

  ///commission-history
  Future<List<Commission>> getCommissionHistory() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(
        "$janaklyan/api/collector/commission/history/${_prefs.getInt("collectorId")}");

    String? token = _prefs.getString('token');

    try {
      var res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      if (200 == res.statusCode) {
        final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();
        print(res.body);
        return parsed
            .map<Commission>((json) => Commission.fromJson(json))
            .toList();
      }
      return List<Commission>.empty();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> commissionAndDeposits() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(
        "$janaklyan/api/collector/commission/info/${_prefs.getInt("collectorId")}");

    String? token = _prefs.getString('token');

    try {
      var res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );
      if (200 == res.statusCode) {
        final parsed = jsonDecode(res.body);
        print(res.body);
        return parsed[0];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<num> getCollector() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt('collectorId');

    Uri url = Uri.parse("$janaklyan/api/collector/get-collector-by-id");

    try {
      print(token);
      print(id);
      var res = await http.post(
        url,
        body: jsonEncode(<String, dynamic>{"id": id}),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );

      if (200 == res.statusCode) {
        var jsonData = jsonDecode(res.body);
        // print(jsonData);
        // setState(() {
        //   totalCollection = jsonData[0]['totalCollection'] ?? 0;
        // });
        return jsonData[0]['totalCollection'];
      } else {
        throw Exception();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<num> getCommission() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString('token');
    final url = Uri.parse(
        "$janaklyan/api/collector/commission/${_prefs.getInt('collectorId')}");

    try {
      var res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
      );
      if (200 == res.statusCode) {
        var jsonData = jsonDecode(res.body);

        return jsonData['commission'];
      } else {
        return 0;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getAll();
  }

  getAll() async {
    setState(() {
      isLoading = true;
    });
    var comAndDeposi = await commissionAndDeposits();
    var collectorDetails = await getCollector();
    var commissionDetails = await getCommission();
    setState(() {
      commission = commissionDetails;
      totalCollection = collectorDetails;
      allTimeCommission = comAndDeposi["allTimeCommission"];
      allTimeDeposits = comAndDeposi["allTimeDeposits"];
      commissionPaid = comAndDeposi["commissionPaid"];
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commission'),
        //backgroundColor: Colors.amber[700],
      ),
      body: Builder(builder: (_) {
        if (isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'note: Your commission is 4%',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                ),
              ),
            ),
            CustomCardDetails(
                label: 'All Time Deposits',
                data: '$allTimeDeposits',
                color: Colors.blue[600]!),
            CustomCardDetails(
                label: 'All Time Commission',
                data: '$allTimeCommission',
                color: Colors.blue[700]!),
            CustomCardDetails(
                label: 'Total Commission Paid',
                data: '$commissionPaid',
                color: Colors.blue[700]!),
            CustomCardDetails(
                label: 'Remaning Commission',
                data: '${allTimeCommission - commissionPaid}',
                color: Colors.blue[700]!),
            CustomCardDetails(
                label: 'Current Wallet Balance',
                data: '$totalCollection',
                color: Colors.blue[800]!),
            CustomCardDetails(
                label: 'Wallet Balance\'s Commission',
                data: '$commission',
                color: Colors.blue[800]!),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                child: FutureBuilder<List<Commission>>(
                  future: getCommissionHistory(),
                  builder: (_, snap) {
                    if (snap.hasData) {
                      return ListView.builder(
                          itemCount: snap.data!.length,
                          itemBuilder: (__, id) {
                            return Card(
                              elevation: 10,
                              child: ListTile(
                                title: Text(
                                  "Commission Paid (Rs):  ${snap.data![id].commissionPaid}",
                                  style: TextStyle(fontSize: 12),
                                ),
                                subtitle: Text(
                                    "Date : ${formatDate(snap.data![id].createdAt)}",
                                    style: TextStyle(fontSize: 12)),
                                trailing: Text(
                                    "ID/C. Id : ${snap.data![id].id}/${snap.data![id].collectorId}",
                                    style: TextStyle(fontSize: 12)),
                              ),
                            );
                          });
                    } else if (snap.hasError) {
                      return Center(child: Text("Some error occured"));
                    } else {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}

class CustomCardDetails extends StatelessWidget {
  const CustomCardDetails(
      {Key? key, required this.data, required this.label, required this.color})
      : super(key: key);
  final String data;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 30,
        width: MediaQuery.of(context).size.width - 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400)),
            SizedBox(
              height: 5,
            ),
            Text(
              data.split(".")[0],
              style: TextStyle(color: Colors.white, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
