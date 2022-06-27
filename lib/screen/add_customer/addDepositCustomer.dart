import 'package:devbynasirulahmed/screen/add_customer/add_cust_mobile_view.dart';
import 'package:devbynasirulahmed/screen/upload/upload_docs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddDepositCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        title: Text(
          'Add Deposit Customer',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body:
        AddDepositCustomer(),
      
    );
  }
}
