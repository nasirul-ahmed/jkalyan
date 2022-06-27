import 'package:devbynasirulahmed/screen/account_register/account_register_view.dart';
import 'package:devbynasirulahmed/screen/apply_loan/apply_loan.dart';
import 'package:devbynasirulahmed/screen/collection/deposit_collection/deposit_collection.dart';
import 'package:devbynasirulahmed/screen/collection/loan_collection/loan_collection_view.dart';
import 'package:devbynasirulahmed/screen/commission/commission.dart';
import 'package:devbynasirulahmed/screen/maturity/maturity_view.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/deposit/deposit_transfer_view.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/loan/transfer_loan_view.dart';
import 'package:devbynasirulahmed/services/loac_customer.dart';
import 'package:flutter/material.dart';

Widget mobileViewDashboard(BuildContext context, int? regularAmount,
    int? loanAmount, int? totalCustomers, int? totalLoanCustomers) {
      
  var screen = MediaQuery.of(context).size;
 
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 140,
                //height: MediaQuery.of(context).size.width / 2,

                child: Card(
                  elevation: 8,
                  color: Colors.pink[500],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Today's",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Deposit C.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          regularAmount != null
                              ? '₹ $regularAmount.0'
                              : '₹ 0.0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 1,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 140,
                //height: MediaQuery.of(context).size.width / 2,
                child: Card(
                  elevation: 8,
                  color: Colors.pink[500],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Today's",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Loan C.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          loanAmount == null ? '₹ 0.0' : '₹ $loanAmount.0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
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
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: Card(
            semanticContainer: false,
            borderOnForeground: false,
            elevation: 5,
            child: Container(
              height: 128,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 150,
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Collection",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DepositCollection(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(color: Colors.pink),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Collection Now",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                totalCustomers == null
                                    ? '(0)'
                                    : '($totalCustomers)',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoanCollectionView(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(color: Colors.pink),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Loan Collection",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                totalCustomers == null
                                    ? '(0)'
                                    : '($totalLoanCustomers)',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Expanded(
          child: Card(
            semanticContainer: false,
            borderOnForeground: false,
            elevation: 5,
            child: Container(
              height: 128,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 150,
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Settlement",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MaturityView()));
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(color: Colors.orange[800]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.send_and_archive_sharp,
                                color: Colors.white,
                                size: 25,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Maturity / Pre-Maturity",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, DepositTransferView.id);
                                        },
                                        child: Container(
                                          width: screen.width,
                                          color: Colors.white,
                                          child: Center(
                                            child: Text(
                                              'Deposit Transfer',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, TransferLoanView.id);
                                        },
                                        child: Container(
                                          width: screen.width,
                                          color: Colors.white,
                                          child: Center(
                                            child: Text(
                                              'Loan Transfer',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(color: Colors.orange[800]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 25,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Money Transfer",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: Card(
            semanticContainer: false,
            borderOnForeground: false,
            elevation: 5,
            child: Container(
              height: 128,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 150,
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Others",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AccountRegisterView(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(color: Colors.orange[800]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fast_forward,
                                color: Colors.white,
                                size: 25,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Account Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, CommissionView.id);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(color: Colors.orange[800]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Icon(
                                Icons.attach_money,
                                color: Colors.white,
                                size: 25,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Commission",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    ),
  );
}
