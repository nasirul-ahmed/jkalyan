import 'dart:convert';
import 'package:devbynasirulahmed/models/deposit_tnx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransferLoanView extends StatefulWidget {
  static final id = "TransferLoanView";
  @override
  _TransferLoanViewState createState() => _TransferLoanViewState();
}

class _TransferLoanViewState extends State<TransferLoanView> {
  Future<List<DepositTnxModel>> getDeposits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Uri url = Uri.parse(
        "https://sanchay-new.herokuapp.com/${prefs.getInt('collectorId')}");

    //try {
    var res = await http.get(
      url,
      // body: jsonEncode(<String, dynamic>{
      //   "colletorId": prefs.getInt('id'),
      // }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        "Authorization": "Bearer ${prefs.getString('token')}"
      },
    );

    if (200 == res.statusCode) {
      final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();
      print(res.body);
      return parsed
          .map<DepositTnxModel>((json) => DepositTnxModel.fromJson(json))
          .toList();
    } else {
      return List<DepositTnxModel>.empty();
    }
    // } catch (e) {
    //   return throw Exception();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deposit History'),
      ),
      body: Builder(builder: (_) {
        return FutureBuilder<List<DepositTnxModel>>(
            future: getDeposits(),
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

  Widget customView(DepositTnxModel? doc) {
    const IconData check = IconData(0xe156, fontFamily: 'MaterialIcons');
    DateTime date = DateTime.parse(doc!.createdAt!);
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
                                "Collector id : " + "${doc.collectorId}",
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
                                "Amount : " + "${doc.amount}",
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
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    //child: Text(name.toString())),
                                    child: RichText(
                                      text: TextSpan(
                                        text: doc.currentStatus == 0
                                            ? "Status: pending"
                                            : "Status: succes",
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
                                  width: 5,
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: CircleAvatar(
                                    backgroundColor: doc.currentStatus == 0
                                        ? Colors.red
                                        : Colors.green,
                                    child: Icon(
                                      doc.currentStatus == 0
                                          ? Icons.watch_later
                                          : check,
                                      size: 19,
                                    ),
                                  ),
                                ),
                              ],
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
