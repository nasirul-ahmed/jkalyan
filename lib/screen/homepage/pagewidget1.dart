import 'package:devbynasirulahmed/screen/add_customer/addDepositCustomer.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

Widget pageWidget1(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 6, right: 6),
    child: Container(
      height: MediaQuery.of(context).size.height - 437,
      width: MediaQuery.of(context).size.width / 2 - 10,
      color: Colors.white,
      child: Row(
        children: [
          Flexible(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddDepositCustomer(),
                          ),
                        );
                      },
                      child: Container(
                          color: Colors.blue[500],
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Add Deposit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.green[700],
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.account_balance_wallet_rounded,
                                size: 25,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Deposit Wallet',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
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
          SizedBox(width: 5),
          Flexible(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                        color: Colors.blue[500],
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Add Loan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.green[700],
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                size: 25,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Loan Wallet',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
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
        ],
      ),
    ),
  );
}
