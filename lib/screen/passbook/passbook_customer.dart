import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
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
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                //padding: EdgeInsets.only(left: 10, right: 10),
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Name :  ${doc!.name}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Account Number :  ${doc!.accountNumber}',
                      style: TextStyle(color: Colors.white),
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
    TextStyle style1 = TextStyle(color: Colors.black, fontSize: 14);
    return SingleChildScrollView(
      child: DataTable(
          columns: [
            DataColumn(label: Text('Date', style: style1)),
            DataColumn(label: Text('Amount Rs', style: style1)),
            DataColumn(label: Text('Collector', style: style1)),
          ],
          rows: list!
              .map((TransactionsModel document) => DataRow(cells: [
                    DataCell(Text(
                      '${document.date?.split("T").first}',
                      style: style,
                    )),
                    DataCell(Text(
                      '${document.amount}',
                      style: style,
                    )),
                    DataCell(Text(
                      '${document.collector}',
                      style: style,
                    )),
                  ]))
              .toList()),
    );
  }

  Future<List<TransactionsModel>> getTransactions() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse("$janaklyan/api/collector/transactions");

    var body = jsonEncode(<String, dynamic>{
      "id": _prefs.getInt('collectorId'),
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
