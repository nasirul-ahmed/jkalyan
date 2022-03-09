import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/loan_customer.dart';
import 'package:devbynasirulahmed/models/loan_transaction.dart';
import 'package:devbynasirulahmed/services/date.format.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanPassbook extends StatelessWidget {
  LoanPassbook(this.doc);
  final LoanCustomer? doc;
  static const id = 'PassbookCustomer';
  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(doc!.updatedAt ?? "");
    var date2 = DateTime.now().difference(date).inDays;
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Passbook'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 130,
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name :  ${doc!.custName}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Loan A/c :  ${doc!.loanAcNo}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Loan Amount :  ${doc!.loanAmount}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Opening Date :  ${formatDate(doc!.createdAt)}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Interest :  ${((doc!.interestRate! * doc!.remLoanAmnt!) / 30 / 100) * date2 + doc!.loanInterest!}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Deposit A/c :  ${doc!.depositAcNo}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder<List<LoanTransactionsModel>>(
                future: getLoanTransactions(),
                builder: (_, snap) {
                  if (snap.hasError) {
                    return Center(
                      child: Text(
                        'Something Wrong here!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else if (snap.hasData) {
                    return renderDatatable(snap.data);
                  }
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  SingleChildScrollView renderDatatable(List<LoanTransactionsModel>? list) {
    TextStyle style = TextStyle(color: Colors.black, fontSize: 12);
    TextStyle style1 = TextStyle(color: Colors.black, fontSize: 12);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 25,
          horizontalMargin: 5,
          columns: [
            DataColumn(label: Text('C. Id', style: style1)),
            DataColumn(label: Text('Date', style: style1)),
            DataColumn(label: Text('Daily C.', style: style1)),
            DataColumn(label: Text('Total C.', style: style1)),
          ],
          rows: list!.map((LoanTransactionsModel document) {
            return DataRow(cells: [
              DataCell(Text(
                '${document.id}',
                style: style,
              )),
              DataCell(Text(
                '${formatDate(document.createdAt)}',
                style: style,
              )),
              DataCell(Text(
                '${document.amount}',
                style: style,
              )),
              DataCell(Text(
                '${document.totalCollection}',
                style: style,
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  Future<List<LoanTransactionsModel>> getLoanTransactions() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse("$janaklyan/api/collector/loan/transactions-by-ac");
    print(doc!.loanAcNo!.toString());
    var body = jsonEncode(<String, dynamic>{
      "collectorId": _prefs.getInt('collectorId'),
      "loanAccountNumber": doc!.loanAcNo
    });

    try {
      var res = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        "Authorization": "Bearer ${_prefs.getString('token')}",
      });
      if (200 == res.statusCode) {
        final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();
        print(parsed);
        return parsed
            .map<LoanTransactionsModel>(
                (json) => LoanTransactionsModel.fromJson(json))
            .toList();
      }

      return List<LoanTransactionsModel>.empty();
    } catch (e) {
      throw Exception(e);
    }
  }
}
