import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/services/date.format.dart';
import 'package:http/http.dart' as http;
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PassbookCustomer extends StatelessWidget {
  PassbookCustomer(this.doc);
  final Customer? doc;
  static const id = 'PassbookCustomer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Passbook'),
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
                height: 100,
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
                            'Name :  ${doc!.name}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Collection Amnt : ${doc!.totalCollection}',
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
                            'Account No :  ${doc!.accountNumber}',
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
                  ],
                ),
              ),
            ),
           
            SizedBox(
              height: 10,
            ),
            FutureBuilder<List<TransactionsModel>>(
                future: getTransactions(),
                builder: (_, snap) {
                  if (snap.hasError) {
                    return Center(
                      child: Text(
                        'Account Number :  ${doc!.accountNumber}',
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

  SingleChildScrollView renderDatatable(List<TransactionsModel>? list) {
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
              DataColumn(label: Text('C.Id', style: style1)),
              DataColumn(label: Text('Date', style: style1)),
              DataColumn(label: Text('Daily C.', style: style1)),
              DataColumn(label: Text('Total C.', style: style1)),
            ],
            rows: list!
                .map((TransactionsModel document) => DataRow(cells: [
                      DataCell(Text(
                        '${document.id}',
                        style: style,
                      )),
                      DataCell(Text(
                        '${formatDate(document.date)}',
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
                    ]))
                .toList()),
      ),
    );
  }

  Future<List<TransactionsModel>> getTransactions() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse("$janaklyan/api/collector/transactions-by-ac");

    var body = jsonEncode(<String, dynamic>{
      "id": _prefs.getInt('collectorId'),
      "accountNumber": doc!.accountNumber
    });
    print(_prefs.getInt('collectorId').toString());
    print(_prefs.getString('token'));
    try {
      var res = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        "Authorization": "Bearer ${_prefs.getString('token')}",
      });
      if (200 == res.statusCode) {
        // return compute(parseTransactions, res.body);
        final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();

        return parsed
            .map<TransactionsModel>((json) => TransactionsModel.fromJson(json))
            .toList();
      }

      return List<TransactionsModel>.empty();
    } catch (e) {
      throw Exception(e);
    }
  }
}
