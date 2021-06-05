import 'package:flutter/material.dart';

class Commission extends StatefulWidget {
  static const String id = "Commission";
  @override
  _CommissionState createState() => _CommissionState();
}

class _CommissionState extends State<Commission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commission'),
        backgroundColor: Colors.amber[700],
      ),
      body: Column(
        children: [
          Card(
            color: Colors.lime[600],
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Commission Percentage',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '5%',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          Card(
            color: Colors.lime[900],
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Today\'s Collection',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '2444',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
