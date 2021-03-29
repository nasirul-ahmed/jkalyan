import 'package:devbynasirulahmed/screen/homepage/desktop_view_dashboard.dart';
import 'package:devbynasirulahmed/screen/homepage/mobile_view_dashboard.dart';
import 'package:devbynasirulahmed/widgets/max_width_container.dart';
import 'package:devbynasirulahmed/widgets/responsive_layout.dart';
import 'package:devbynasirulahmed/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:devbynasirulahmed/services/auth_service.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final firbaseUser = context.watch<User?>();
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('DashBoard'),
        backgroundColor: Colors.pink[900],
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                AuthServices(FirebaseAuth.instance).signOut();
              },
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          MaxWidthContainer(
            child: Responsivelayout(
              mobileView: mobileViewDashboard(context),
              tabletView: desktopViewDashboard(context),
            ),
          )
        ],
      ),
    );
  }

  Widget collectionContainer(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.height / 2,
            height: 150,
            //height: MediaQuery.of(context).size.width / 2,

            child: Card(
              elevation: 16,
              color: Colors.yellow[800],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Daily Deposit Collection',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '00.0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.height / 2,
            height: 150,
            //height: MediaQuery.of(context).size.width / 2,
            child: Card(
              elevation: 16,
              color: Colors.yellow[800],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Daily Loan Collection',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '00.0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
