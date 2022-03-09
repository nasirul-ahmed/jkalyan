import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/screen/homepage/mobile_view_dashboard.dart';
import 'package:devbynasirulahmed/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DashBoard extends StatefulWidget {
  static const String id = 'DashBoard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int? regularAmount;
  int? loanAmount;
  int? totalCustomers;
  int? totalLoanCustomers;
  DateTime getDate = DateTime.now();

  getBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt('collectorId');

    Uri url = Uri.parse("$janaklyan/api/collector/todays-deposit-collection");

    try {
      var res = await http.post(
        url,
        body: jsonEncode(<String, dynamic>{
          "id": id,
          "date": "${getDate.year}-${getDate.month}-${getDate.day}"
        }),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );

      if (200 == res.statusCode) {
        var jsonData = jsonDecode(res.body);

        print(jsonData.toString());
        setState(() {
          regularAmount = jsonData['todaysCollection'];
        });

        return jsonData;
      } else {
        print(res.statusCode);
      }
    } catch (e) {}
  }

  getLoanBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt('collectorId');

    Uri url = Uri.parse("$janaklyan/api/collector/todays-loan-collection");

    try {
      var res = await http.post(
        url,
        body: jsonEncode(<String, dynamic>{
          "id": id,
          "date": DateTime.now().toString().split(" ")[0]
        }),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );

      if (200 == res.statusCode) {
        var jsonData = jsonDecode(res.body);

        print(jsonData.toString());
        setState(() {
          loanAmount = jsonData['todaysLoanCollection'];
        });

        return jsonData;
      } else {
        print(res.statusCode);
      }
    } catch (e) {}
  }

  totalCustomer() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final url = Uri.parse(
        '$janaklyan/api/collector/total/customers/${_prefs.getInt('collectorId')}');

    try {
      print(_prefs.getInt('collectorId'));
      var res = await http.get(url, headers: {
        "Content-Type": "application/json",
        'Accept': "*/*",
        "Authorization": "Bearer ${_prefs.getString('token')}"
      });
      if (200 == res.statusCode) {
        var jsondata = jsonDecode(res.body);
        setState(() {
          totalCustomers = jsondata['totalCustomers'];
        });
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  void initState() {
    super.initState();
    getBalance();
    getLoanBalance();
    totalCustomer();
  }

  @override
  Widget build(BuildContext context) {
    //final firbaseUser = context.watch<User?>();
    return Scaffold(
      extendBodyBehindAppBar: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          totalCustomer();
          getBalance();
          getLoanBalance();
        },
        materialTapTargetSize: MaterialTapTargetSize.padded,
        mini: false,
        backgroundColor: Colors.green,
        child: Icon(Icons.replay_rounded),
      ),
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('DashBoard'),
        backgroundColor: Colors.pink[900],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            mobileViewDashboard(context, regularAmount, loanAmount,
                totalCustomers, totalLoanCustomers)
          ],
        ),
      ),
    );
  }
}
