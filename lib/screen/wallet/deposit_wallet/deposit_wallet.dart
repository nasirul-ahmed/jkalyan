import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/collector.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepositWallet extends StatelessWidget {
  const DepositWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Deposit Wallet'),
        ),
        body: Column(
          children: [
            Card(
              child: Container(
                height: screen.height * 0.3,
                width: screen.width,
                color: Colors.red,
                child: FutureBuilder<Collector>(
                  future: future(),
                  builder: (_, snap) {
                    if (snap.hasError) {
                      return Center(
                        child: Text('Error'),
                      );
                    } else if (snap.hasData) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Total Balance in your Wallet',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            SizedBox(
                              height: 10,
                            ),
                            Text("₹ ${snap.data!.totalCollection}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                          height: 30,
                          width: 30,
                          child: Center(child: CircularProgressIndicator()));
                    }
                  },
                ),
              ),
            )
          ],
        ));
  }

  Future<Collector> future() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString('token');
    print(_prefs.getInt('collectorId').toString());
    final url = Uri.parse("$janaklyan/api/collector/get-total-collection");

    try {
      var res = await http.post(
        url,
        body: jsonEncode(
            <String, dynamic>{"collectorId": _prefs.getInt("collectorId")}),
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Authorization": "Bearer $token",
        },
      );
      print(res.statusCode);
      if (200 == res.statusCode) {
        var jsonData = jsonDecode(res.body);
        print(jsonData);
        return Collector.fromJson(jsonData[0]);
      } else {
        return throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
