import 'dart:convert';
import 'package:devbynasirulahmed/models/deposit_tnx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:font_awesome_flutter_example/icons.dart';

class DepositTransferView extends StatefulWidget {
  static final id = "DepositTransferView";
  @override
  _DepositTransferViewState createState() => _DepositTransferViewState();
}

class _DepositTransferViewState extends State<DepositTransferView> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Deposit Transfer'),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                elevation: 16,
                child: Container(
                  height: 200,
                  width: screen.width,
                  decoration: BoxDecoration(color: Colors.orange[800]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total Deposit Balance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '00.00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    'note: You can\'t undo once money is send',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: screen.width - 40,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Payment Status and History',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: SizedBox(),
            // ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: screen.width - 40,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Send',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
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
      ),
    );
  }
}
