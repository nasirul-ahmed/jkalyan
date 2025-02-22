import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/screen/account_register/account_register_view.dart';
import 'package:devbynasirulahmed/screen/add_customer/addDepositCustomer.dart';
import 'package:devbynasirulahmed/screen/add_customer/add_cust_mobile_view.dart';
import 'package:devbynasirulahmed/screen/loan_applications/loan_applications.dart';
import 'package:devbynasirulahmed/screen/maturity/sent_maturity/sent_maturity.dart';
import 'package:devbynasirulahmed/screen/old_customers/old_viewer.dart';
import 'package:devbynasirulahmed/screen/passbook/loan_passbook/loan_passbook_search.dart';
import 'package:devbynasirulahmed/screen/passbook/passbook.dart';
import 'package:devbynasirulahmed/screen/tnx/loan_tnx.dart';
import 'package:devbynasirulahmed/screen/tnx/transactions.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/deposit/transfer_deposit.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/loan/transfer_loan.dart';
import 'package:devbynasirulahmed/screen/upload/upload_docs.dart';
import 'package:devbynasirulahmed/screen/wallet/deposit_wallet/deposit_wallet.dart';
import 'package:devbynasirulahmed/screen/wallet/loan_wallet/loan_wallet.dart';
import 'package:devbynasirulahmed/services/auth/logout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  // late Future<ApiResponse<Collector>> _getCollector;

  String? email;
  String? name;
  int? id;
  int? totalCustomer;

  getEmail() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      email = _prefs.getString("email");
      name = _prefs.getString("name");
      id = _prefs.getInt("collectorId");
    });
  }

  Future<void> getTotalCustomers() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Uri uri = Uri.parse(
        '$janaklyan/api/collector/total/customers/${_prefs.getInt("collectorId")}');

    try {
      final res = await http.get(uri,
          // body:
          //     jsonEncode(<String, dynamic>{"id": _prefs.getInt("collectorId")}),
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
            "Authorization": "Bearer ${_prefs.getString('token')}"
          });

      if (200 == res.statusCode) {
        var jsonData = jsonDecode(res.body);
        print(jsonData);

        setState(() {
          totalCustomer = jsonData['totalCustomers'];
        });
      } else {}
    } catch (e) {
      throw Exception('Error');
    }
  }

  @override
  void initState() {
    super.initState();
    //_getCollector = getCollector();
    getEmail();
    //getTotalCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            InkWell(
              focusColor: Colors.blueGrey[800],
              splashColor: Colors.blueGrey[800],
              onTap: () {},
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orange[700],
                  child: Icon(Icons.person, color: Colors.white),
                ),
                accountEmail: Text(email ?? 'Collector Code: $id'),
                accountName:
                    Text('Collector Code: $id', style: TextStyle(fontSize: 20)),
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.green,
                  //shape: BoxShape.circle,
                ),
              ),
            ),
            ExpansionTile(
              leading: FaIcon(
                Icons.find_replace_rounded,
                size: 20,
                color: Colors.green,
              ),
              title: Text('Account'),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Passbook',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => PassBook()));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Loan Passbook',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => LoanPassBookSearch()));
                      },
                    ),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              leading: FaIcon(
                Icons.history,
                size: 20,
                color: Colors.green,
              ),
              title: Text('Transfer History'),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Deposit History',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, TransferDeposit.id);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Loan Deposit History',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TransferLoan(),
                            ));
                      },
                    ),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              leading: FaIcon(
                Icons.history,
                size: 20,
                color: Colors.green,
              ),
              title: Text('Transaction History'),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Tnx History',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, TransactionsView.id);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Loan Tnx History',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => LoanTransactionsView()));
                      },
                    ),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              leading: FaIcon(
                Icons.account_balance_wallet_outlined,
                size: 20,
                color: Colors.green,
              ),
              title: Text('Wallet'),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      title: Text(
                        'Deposit Wallet',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => DepositWallet()));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListTile(
                      title: Text(
                        'Loan Wallet',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoanWallet()));
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: FaIcon(
                  Icons.format_list_bulleted_rounded,
                  color: Colors.green,
                  size: 20,
                ),
                title: Text(
                  'Loan Applications',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => LoanApplications()));
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: FaIcon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 20,
                ),
                title: Text(
                  'Check Maturity Status',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SentMaturity()));
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: FaIcon(
                  Icons.person_add,
                  color: Colors.green,
                  size: 20,
                ),
                title: Text(
                  'Add Customer',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => UploadDocs()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Opacity(
                opacity: 0.5,
                child: Divider(
                  height: 1,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              child: ListTile(
                onTap: () async {
                  //Provider.of<AuthNotifier>(context, listen: false).logOut();
                  AuthHandle().logOut(context);
                },
                title: Text(
                  'Log Out',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                '@devbyNasirul',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
