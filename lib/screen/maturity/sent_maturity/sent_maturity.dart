import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/maturity_model.dart';
import 'package:devbynasirulahmed/screen/maturity/sent_maturity/details_maturity.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SentMaturity extends StatefulWidget {
  SentMaturity({Key? key}) : super(key: key);

  @override
  _SentMaturityState createState() => _SentMaturityState();
}

class _SentMaturityState extends State<SentMaturity> {
  bool isTaped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(isTaped ? "Success Maturity List" : 'Pending Maturity List'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isTaped = !isTaped;
                });
              },
              icon: Icon(
                Icons.swap_vert_circle,
                size: 30,
              ),
            )
          ],
        ),
        body: FutureBuilder<List<MaturityModel>>(
            future:
                isTaped ? getPendingMaturity(true) : getPendingMaturity(false),
            builder: (_, snap) {
              if (snap.hasError) {
                print(snap.error.toString());
                return Center(
                  child: Text("Something went wrong"),
                );
              } else if (snap.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snap.data?.length,
                    itemBuilder: (__, id) {
                      return customContainer(snap.data![id]);
                      //return Text('hello there');
                    });
              } else
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.pink,
                  ),
                );
            }));
  }

  Widget customContainer(MaturityModel doc) {
    const style = TextStyle(
        color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal);
    const style2 = TextStyle(
        color: Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 2);
    return InkWell(
      onTap: () {
        if (doc.isMatured == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => DetailsMaturity(
                        doc: doc,
                      )));
        }
      },
      child: Card(
        elevation: 16,
        child: Container(
          height: 80,
          decoration: BoxDecoration(color: Colors.blueGrey[600]),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    height: 15,
                    width: 100,
                    color: Colors.white,
                    child: doc.isMatured == 1
                        ? Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Processing',
                                  style: style2,
                                )
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Pending',
                                  style: style2,
                                )
                              ],
                            ),
                          )),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${doc.custName}",
                          style: style,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("(A/c: ${doc.accountNumber})", style: style),
                      ],
                    ),
                    Text(
                        "Submit Date: ${doc.submitDate.toString().split("T")[0]}",
                        style: style),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Net Balance:  ${doc.totalAmount}", style: style),
                    doc.isMatured == 1
                        ? Text(
                            "Process Date : ${doc.processDate.toString().split("T")[0]}",
                            style: style)
                        : Text(
                            "Opening Date:  ${doc.openingDate.toString().split("T")[0]}",
                            style: style),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<MaturityModel>> getPendingMaturity(bool x) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final url;
    if (x) {
      url = Uri.parse('$janaklyan/api/collector/maturity-success');
    } else {
      url = Uri.parse('$janaklyan/api/collector/maturity-pendings');
    }

    var body = jsonEncode({
      "collectorId": _prefs.getInt('collectorId'),
    });

    try {
      var res = await http.post(
        url,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Authorization": "Bearer ${_prefs.getString('token')}"
        },
      );
      if (200 == res.statusCode) {
        print(res.body.toString());
        final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();

        return parsed
            .map<MaturityModel>((json) => MaturityModel.fromJson(json))
            .toList();
      }
      return List<MaturityModel>.empty();
    } catch (e) {
      throw Exception(e);
    }
  }
}
