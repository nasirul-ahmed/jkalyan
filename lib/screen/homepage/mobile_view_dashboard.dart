import 'dart:convert';

import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/screen/add_customer/addDepositCustomer.dart';
import 'package:devbynasirulahmed/screen/collection/deposit_collection/deposit_collection.dart';
import 'package:devbynasirulahmed/screen/edit_customer/depost/edit_deposit_customer.dart';
import 'package:devbynasirulahmed/screen/edit_customer/depost/search_deposit.dart';
import 'package:devbynasirulahmed/screen/edit_customer/loan/edit_loan_customer.dart';
import 'package:devbynasirulahmed/screen/homepage/pageWidget2.dart';
import 'package:devbynasirulahmed/screen/homepage/pagewidget1.dart';
import 'package:devbynasirulahmed/services/customer_service.dart';
import 'package:devbynasirulahmed/widgets/all_customers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Widget mobileViewDashboard(BuildContext context, int regularAmount,
    int loanAmount, int totalCustomers, int totalLoanCustomers) {
  PageController pageController = PageController(initialPage: 0);
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 100,
                //height: MediaQuery.of(context).size.width / 2,

                child: Card(
                  elevation: 8,
                  color: Colors.pink[500],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Deposit Collection',
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
                          '₹ $regularAmount.0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
                height: 100,
                //height: MediaQuery.of(context).size.width / 2,
                child: Card(
                  elevation: 8,
                  color: Colors.pink[500],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Loan Collection',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '₹ $loanAmount.0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
        Card(
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
                GestureDetector(
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
                            "Regular Customers",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '($totalCustomers)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // FutureBuilder<List<Customer>>(
                          //   future: getCustomer(),
                          //   builder: (_, snap) {
                          //     if (snap.hasData) {
                          //       return Text(
                          //         '(${snap.data!.length})',
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 18,
                          //           fontWeight: FontWeight.w400,
                          //         ),
                          //       );
                          //     } else if (snap.hasError) {
                          //       return Text('null');
                          //     } else {
                          //       return Center(
                          //         child: CircularProgressIndicator(
                          //           backgroundColor: Colors.white,
                          //           strokeWidth: 2,
                          //         ),
                          //       );
                          //     }
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
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
                          "Loan Customers",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '($totalLoanCustomers)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Card(
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
                        "Edit Customers",
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
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, SearchDeposit.id);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(color: Colors.orange[800]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Edit Regular Customers",
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
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(color: Colors.orange[800]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Edit Loan Customer",
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
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),

        Flexible(
          child: PageView(
            controller: pageController,
            children: [
              pageWidget2(context),
              pageWidget1(context),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        )
        // SizedBox(
        //   height: 5,
        // ),
        // GestureDetector(
        //   onTap: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => AllCustomers()));
        //   },
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Colors.orange[800],
        //       borderRadius: BorderRadius.circular(6),
        //     ),
        //     height: 50,
        //     width: MediaQuery.of(context).size.width - 20,
        //     //color: Colors.orange[700],
        //     child: Center(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Icon(
        //             Icons.grading_outlined,
        //             color: Colors.white,
        //             size: 30,
        //           ),
        //           SizedBox(
        //             width: 15,
        //           ),
        //           Text(
        //             'All Customer',
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 22,
        //               fontWeight: FontWeight.w500,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: 5,
        // ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 10, right: 5),
        //         child: GestureDetector(
        //           onTap: () {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => AddDepositCustomer()));
        //           },
        //           child: Container(
        //             decoration: BoxDecoration(
        //               color: Colors.green[700],
        //               borderRadius: BorderRadius.circular(6),
        //             ),
        //             height: 50,
        //             //width: MediaQuery.of(context).size.width / 2 - 16,
        //             //color: Colors.pink[900],
        //             child: Center(
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(
        //                     Icons.add,
        //                     color: Colors.white,
        //                     size: 25,
        //                   ),
        //                   SizedBox(
        //                     width: 5,
        //                   ),
        //                   Text(
        //                     'Add Customer',
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                       fontSize: 16,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     // SizedBox(
        //     //   width: 10,
        //     // ),
        //     Expanded(
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 5, right: 10),
        //         child: GestureDetector(
        //           onTap: () {
        //             Navigator.of(context).push(MaterialPageRoute(
        //                 builder: (context) => EditCustomer()));
        //           },
        //           child: Container(
        //             // width: MediaQuery.of(context).size.width / 2 - 16,
        //             height: 50,
        //             decoration: BoxDecoration(
        //               color: Colors.orange[800],
        //               borderRadius: BorderRadius.circular(6),
        //             ),
        //             //color: Colors.pink[900],
        //             child: Center(
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(
        //                     Icons.edit,
        //                     color: Colors.white,
        //                     size: 22,
        //                   ),
        //                   SizedBox(
        //                     width: 5,
        //                   ),
        //                   Text(
        //                     'Edit Customer',
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                       fontSize: 16,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // MaterialButton(
        //   onPressed: () {
        //     Navigator.of(context).push(
        //         MaterialPageRoute(builder: (context) => UploadProfile(9503)));
        //   },
        //   child: Text('upload image'),
        // )
        //Text('customer ac no: '),
      ],
    ),
  );
}
