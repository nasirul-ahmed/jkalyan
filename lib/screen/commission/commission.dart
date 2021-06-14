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
                    '00.00',
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
                      '00.00',
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
      ),
    );
  }
}
