import 'dart:async';

import 'package:devbynasirulahmed/screen/apply_loan/apply_loan.dart';
import 'package:devbynasirulahmed/screen/collection/deposit_collection/collection.dart';
import 'package:devbynasirulahmed/screen/commission/commission.dart';
import 'package:devbynasirulahmed/screen/edit_customer/depost/edit_deposit_customer.dart';
import 'package:devbynasirulahmed/screen/edit_customer/depost/search_deposit.dart';
import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';
import 'package:devbynasirulahmed/screen/login/login.dart';
import 'package:devbynasirulahmed/screen/passbook/passbook_customer.dart';
import 'package:devbynasirulahmed/screen/tnx/transactions.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/deposit/deposit_transfer_view.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/deposit/transfer_deposit.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/loan/transfer_loan_view.dart';
import 'package:devbynasirulahmed/screen/upload/reupload.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
      //initialRoute: '/splash',
      routes: {
        '/dashboard': (context) => DashBoard(),
        '/login': (context) => Login(),
        DashBoard.id: (context) => DashBoard(),
        ReUploadProfile.id: (context) => ReUploadProfile(),
        TransactionsView.id: (context) => TransactionsView(),
        TransferDeposit.id: (_) => TransferDeposit(),
        Commission.id: (_) => Commission(),
        //EditDepositCustomer.id: (_) => EditDepositCustomer(),
        SearchDeposit.id: (_) => SearchDeposit(),
        DepositTransferView.id: (_) => DepositTransferView(),
        TransferLoanView.id: (_) => TransferLoanView(),
        ApplyLoan.id: (_) => ApplyLoan(),
        //PassbookCustomer.id:(_)=> PassbookCustomer(doc)
      },
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void setTimer() {
    Timer(Duration(seconds: 3), () => {navigateUser()});
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogged = prefs.getBool('isLogged') ?? false;
    print(isLogged);
    if (isLogged) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/dashboard', (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    setTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
