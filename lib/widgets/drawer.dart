import 'package:devbynasirulahmed/models/api_response.dart';
import 'package:devbynasirulahmed/screen/upload/reupload.dart';
import 'package:devbynasirulahmed/services/collector/collector.services.dart';
import 'package:devbynasirulahmed/services/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:devbynasirulahmed/models/api_response.dart';
import 'package:devbynasirulahmed/models/collector.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Future<ApiResponse<Collector>> _getCollector;
  @override
  void initState() {
    super.initState();
    _getCollector = getCollector();
  }

  @override
  Widget build(BuildContext context) {
    //final firbaseUser = context.watch<User?>();
    return Drawer(
      child: Container(
        //decoration: BoxDecoration(color: Colors.blue[200]),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            GestureDetector(
              child: UserAccountsDrawerHeader(
                accountEmail:
                    FuturBuilder<ApiResponse<Collector>>(builder: (_, snap) {
                  if (snap.hasError) {
                    return Text('error');
                  }
                  return Text('${snap.data?.data?.email}');
                }),
                // accountEmail: Text(
                //   firbaseUser == null ? '' : '${firbaseUser.email}',
                //   style: TextStyle(fontSize: 18),
                // ),
                accountName: Text('Manager', style: TextStyle(fontSize: 20)),
                margin: EdgeInsets.zero,
                //padding: EdgeInsets.fromLTRB(0.0, 16.0, 150, 16.0),
                // currentAccountPicture: Image(
                //   //radius: 30.0,
                //   image: AssetImage('images/appstore.png'),
                // ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[600],
                  //shape: BoxShape.circle,
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.white,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Icon(
                  Icons.pending_actions,
                  color: Colors.black,
                  size: 30,
                ),
                title: Text(
                  'Agent Deposits',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ),
            Divider(
              height: 1,
              color: Colors.white,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Icon(
                  Icons.upload_file,
                  color: Colors.black,
                  size: 30,
                ),
                title: Text(
                  'Upload',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pushNamed(context, ReUploadProfile.id);
                },
              ),
            ),
            Divider(
              height: 1,
              color: Colors.white,
            ),
            Container(
              child: ListTile(
                onTap: () async {
                  Provider.of<AuthNotifier>(context, listen: false).logOut();
                },
                title: Text(
                  'Log Out',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            Container(
              child: Text(
                '@devbyNasirul',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
