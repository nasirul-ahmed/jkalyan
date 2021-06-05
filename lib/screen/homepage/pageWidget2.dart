import 'package:devbynasirulahmed/screen/commission/commission.dart';
import 'package:devbynasirulahmed/screen/tnx/transactions.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/deposit/transfer_deposit.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/loan/transfer_loan_view.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

Widget pageWidget2(BuildContext context) {
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
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Commission.id);
                      },
                      child: Container(
                          color: Colors.red,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.wallet_giftcard_rounded,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Commission',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
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
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, TransferDeposit.id);
                      },
                      child: Container(
                        color: Colors.pink[800],
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.send_to_mobile,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Transfer Deposit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, TransactionsView.id);
                      },
                      child: Container(
                          color: Colors.red,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.history_toggle_off_sharp,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Tnx History',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
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
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, TransferLoanView.id);
                      },
                      child: Container(
                        color: Colors.pink[800],
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.send_to_mobile,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Transfer Loan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
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
