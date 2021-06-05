import 'dart:convert';
import 'package:devbynasirulahmed/models/transactions.dart';
import 'package:devbynasirulahmed/widgets/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionsView extends StatefulWidget {
  static const String id = 'TransactionsView';
  @override
  _TransactionsViewState createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  Future<List<TransactionsModel>> getTnx() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Uri url = Uri.parse(
        "https://sanchay-new.herokuapp.com/api/collector/transactions");

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: Builder(builder: (_) {
        return FutureBuilder<List<TransactionsModel>>(
            future: getTnx(),
            builder: (__, snap) {
              if (snap.hasError)
                return Center(
                  child: Text(
                    snap.error.toString(),
                  ),
                );
              if (snap.hasData) {
                return ListView.builder(
                    itemCount: snap.data?.length,
                    itemBuilder: (___, indx) {
                      return customView(snap.data?[indx]);
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            });
      }),
    );
  }

  Widget customView(doc) {
    DateTime date = DateTime.parse(doc.date);
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: Container(
          color: Colors.grey[300],
          height: 130,
          width: MediaQuery.of(context).size.width - 20,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 30,
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Tnx Id-${doc.id}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Collector id : " + doc.collector.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Amount : " + doc.amount.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        //color: Colors.amber,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                //child: Text(name.toString())),
                                child: RichText(
                                  text: TextSpan(
                                    text: "A/c No : " +
                                        doc.customer_account.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                //child: Text(name.toString())),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Date : " +
                                        "${date.day}-${date.month}-${date.year}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
