import 'package:devbynasirulahmed/widgets/search_customer.dart';
import 'package:flutter/material.dart';

class PassBook extends StatefulWidget {
  @override
  _PassBookState createState() => _PassBookState();
}

class _PassBookState extends State<PassBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          SearchCustomer(),
        ],
      ),
    );
  }
}
