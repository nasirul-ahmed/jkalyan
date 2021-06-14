import 'dart:convert';
import 'package:devbynasirulahmed/models/deposit_tnx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransferLoanView extends StatefulWidget {
  static final id = "TransferLoanView";
  @override
  _TransferLoanViewState createState() => _TransferLoanViewState();
}

class _TransferLoanViewState extends State<TransferLoanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[800],
        title: Text('Loan Transfer'),
      ),
      body: Container(),
    );
  }
}
