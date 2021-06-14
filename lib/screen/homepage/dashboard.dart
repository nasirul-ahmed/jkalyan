import 'dart:convert';
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
  int regularAmount = 0;
  int loanAmount = 0;
  int totalCustomers = 0;
  int totalLoanCustomers = 0;
  DateTime getDate = DateTime.now();

  getBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt('collectorId');

    Uri url = Uri.parse(
        "https://sanchay-new.herokuapp.com/api/collector/todays-deposit-collection");

    try {
      print("${getDate.year}-${getDate.month}-${getDate.day}");
      print(id);
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
          regularAmount = jsonData['sum(amount)'] ?? 0;
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

    Uri url = Uri.parse(
        "https://sanchay-new.herokuapp.com/api/collector/loan/todays-deposit-collection");

    try {
      print(token);
      print(id);
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

        print(jsonData[0].toString());
        setState(() {
          regularAmount = jsonData['sum(amount)'];
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
        'https://sanchay-new.herokuapp.com/api/total/customers/${_prefs.getInt('collectorId')}');

    var body = jsonEncode({
      "id": _prefs.getInt('collectorId'),
    });

    try {
      var res = await http.get(url, headers: {
        "Content-Type": "application/json",
        'Accept': "*/*",
        "Authorization": "Bearer ${_prefs.getString('token')}"
      });
      if (200 == res.statusCode) {
        var jsondata = jsonDecode(res.body);
        setState(() {
          totalCustomers = jsondata['count(id)'];
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
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          mobileViewDashboard(context, regularAmount, loanAmount,
              totalCustomers, totalLoanCustomers)
        ],
      ),
    );
  }
}
