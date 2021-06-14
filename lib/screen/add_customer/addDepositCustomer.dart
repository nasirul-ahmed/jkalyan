import 'package:devbynasirulahmed/screen/add_customer/add_cust_desktop_view.dart';
import 'package:devbynasirulahmed/screen/add_customer/add_cust_mobile_view.dart';
import 'package:devbynasirulahmed/widgets/max_width_container.dart';
import 'package:devbynasirulahmed/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddDepositCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[900],
          title: Text('Add Deposit Customer'),
        ),
        body: Scrollbar(
          child: MaxWidthContainer(
            child: Responsivelayout(mobileView: AddCustomerMV()),
          ),
        ));
  }
}
