import 'package:devbynasirulahmed/models/api_response.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/deposit/deposit_transfer_view.dart';
import 'package:devbynasirulahmed/screen/upload/reupload.dart';
import 'package:devbynasirulahmed/services/collector/collector.services.dart';
import 'package:devbynasirulahmed/services/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:devbynasirulahmed/models/collector.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  // late Future<ApiResponse<Collector>> _getCollector;

  String? email;
  String? name;

  getEmail() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      email = _prefs.getString("email");
      name = _prefs.getString("name");
    });
  }

  @override
  void initState() {
    super.initState();
    //_getCollector = getCollector();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GestureDetector(
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orange[700],
                  child: Icon(Icons.person, color: Colors.white),
                ),
                accountEmail: Text(email ?? ''),
                accountName: Text('$name', style: TextStyle(fontSize: 20)),
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
                  Icons.person_outline,
                  color: Colors.green,
                  size: 20,
                ),
                title: Text(
                  'Customers',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pushNamed(context, ReUploadProfile.id);
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
                  Provider.of<AuthNotifier>(context, listen: false).logOut();
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
