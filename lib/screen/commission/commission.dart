import 'dart:convert';

import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Commission extends StatefulWidget {
  static const String id = "Commission";
  @override
  _CommissionState createState() => _CommissionState();
}

class _CommissionState extends State<Commission> {
  num? commission;
  num? totalCollection;
  bool isLoading = false;

  getCollector() async {
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
        print(jsonData);
        setState(() {
          totalCollection = jsonData[0]['totalCollection'] ?? 0;
        });
      } else {
        return;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> getCommission() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString('token');
    final url = Uri.parse(
        "$janaklyan/api/collector/commission/${_prefs.getInt('collectorId')}");

    try {
      var res = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (200 == res.statusCode) {
        var jsonData = jsonDecode(res.body);
        setState(() {
          commission = jsonData['commission'] ?? 0;
        });
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

  getAll() {
    setState(() {
      isLoading = true;
    });
    getCommission();
    getCollector();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commission'),
        backgroundColor: Colors.amber[700],
      ),
      body: Builder(builder: (_) {
        if (isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'note: Your commission is 4%',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.grey,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Wallet Balance',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      totalCollection != null ? '$totalCollection' : '0',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Card(
                color: Colors.blue[700],
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Commission Balance',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        commission != null ? '$commission' : '0',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        );
      }),
    );
  }
}
