import 'dart:convert';
import 'package:devbynasirulahmed/screen/old_customers/old_viewer.dart';
import 'package:devbynasirulahmed/screen/tnx/transactions.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/deposit/deposit_transfer_view.dart';
import 'package:devbynasirulahmed/screen/upload/reupload.dart';
import 'package:devbynasirulahmed/screen/wallet/passbook.dart';
import 'package:devbynasirulahmed/services/auth/logout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  // late Future<ApiResponse<Collector>> _getCollector;

  String? email;
  String? name;
  int? id;
  int totalCustomer = 0;

  getEmail() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      email = _prefs.getString("email");
      name = _prefs.getString("name");
      id = _prefs.getInt("collectorId");
    });
  }

  getTotalCustomers() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Uri uri = Uri.parse(
        'https://janakalyan-ag.herokuapp.com/api/collector/total/customers/${_prefs.getInt("collectorId")}');

    try {
      final res = await http.get(uri,
          // body:
          //     jsonEncode(<String, dynamic>{"id": _prefs.getInt("collectorId")}),
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": "Bearer ${_prefs.getString('token')}"
          });

      if (200 == res.statusCode) {
        var jsonData = jsonDecode(res.body);
        print(jsonData);

        setState(() {
          totalCustomer = jsonData['totalCustomers'];
        });
      } else {}
    } catch (e) {
      throw Exception('Error');
    }
  }

  @override
  void initState() {
    super.initState();
    //_getCollector = getCollector();
    getEmail();
    getTotalCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            InkWell(
              focusColor: Colors.blueGrey[800],
              splashColor: Colors.blueGrey[800],
              onTap: () {},
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orange[700],
                  child: Icon(Icons.person, color: Colors.white),
                ),
                accountEmail: Text(email ?? 'Collector Code: $id'),
                accountName:
                    Text('Collector Code: $id', style: TextStyle(fontSize: 20)),
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.green,
                  //shape: BoxShape.circle,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Icon(
                  Icons.book_rounded,
                  color: Colors.green,
                  size: 20,
                ),
                title: Text(
                  'Passbook',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => PassBook()));
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Icon(
                  Icons.pending_actions,
                  color: Colors.green,
                  size: 20,
                ),
                title: Text(
                  'Deposits History',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pushNamed(context, DepositTransferView.id);
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Icon(
                  Icons.pending_actions,
                  color: Colors.green,
                  size: 20,
                ),
                title: Text(
                  'Transaction History',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pushNamed(context, TransactionsView.id);
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Icon(
                  Icons.person_outline,
                  color: Colors.green,
                  size: 20,
                ),
                title: Text(
                  'Closed A/c ($totalCustomer)',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => OldCustomerView()));
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Icon(
                  Icons.upload_file,
                  color: Colors.green,
                  size: 20,
                ),
                title: Text(
                  'Upload',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pushNamed(context, ReUploadProfile.id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Divider(
                height: 1,
                color: Colors.black,
              ),
            ),
            Container(
              child: ListTile(
                onTap: () async {
                  //Provider.of<AuthNotifier>(context, listen: false).logOut();
                  AuthHandle().logOut(context);
                },
                title: Text(
                  'Log Out',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                '@devbyNasirul',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
