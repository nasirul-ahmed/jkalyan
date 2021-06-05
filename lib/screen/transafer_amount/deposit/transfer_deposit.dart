import 'dart:convert';
import 'package:devbynasirulahmed/models/api_response.dart';
import 'package:devbynasirulahmed/models/collector.dart';
import 'package:devbynasirulahmed/models/deposit_tnx.dart';
import 'package:devbynasirulahmed/screen/transafer_amount/deposit/deposit_transfer_view.dart';
import 'package:devbynasirulahmed/services/collector/collector.services.dart';
import 'package:devbynasirulahmed/services/deposits_tnx/depost_tnx.services.dart';
import 'package:devbynasirulahmed/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransferDeposit extends StatefulWidget {
  static const String id = 'TransferDeposit';
  @override
  _TransferDepositState createState() => _TransferDepositState();
}

class _TransferDepositState extends State<TransferDeposit> {
  handlePress() async {
    showLoadingDialog(context);
    DateTime date = DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt('collectorId');

    Uri url = Uri.parse(
        "https://sanchay-new.herokuapp.com/api/collector/create/deposit/tnx");

    try {
      var res = await http.post(
        url,
        body: jsonEncode(<String, dynamic>{
          "collectorId": id,
          "date": "${date.year}-${date.month}-${date.day}",
        }),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );

      if (200 == res.statusCode) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Sent to manager');
      } else {
        Navigator.pop(context);
        showErrorDialog(context);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    void openDialoag() {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              actions: [
                MaterialButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.pop(context);
                    handlePress();
                  },
                ),
              ],
              title: Text(
                'Warning',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              content: Text('Do you want proceed?'),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer Deposit"),
        backgroundColor: Colors.amber[800],
      ),
      body: Column(
        children: [
          Card(
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Total Collected Amount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    FutureBuilder<ApiResponse<Collector>>(
                      future: getCollector(),
                      builder: (_, snap) {
                        if (snap.hasError) {
                          return Center(child: Text("unable to fetch"));
                        }

                        return Text(
                          '₹ ${snap.data?.data?.totalCollection ?? 0}.00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                    InkWell(
                      onTap: () {
                        openDialoag();

                        //handlePress();
                      },
                      child: Container(
                        height: 30,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'Send to manager',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Deposits',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, DepositTransferView.id);
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
              ],
            ),
          ),
          Flexible(
            child: Card(
              color: Colors.grey[300],
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 5,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                child: FutureBuilder<List<DepositTnxModel>>(
                  future: getDepositsTnx(),
                  builder: (_, snap) {
                    if (snap.hasError) {
                      return Center(
                        child: Text('Somthing Wrong'),
                      );
                    }
                    if (snap.hasData) {
                      return ListView.builder(
                        //controller: _scrollController,
                        //shrinkWrap: true,
                        itemCount:
                            snap.data!.length < 10 ? snap.data!.length : 10,
                        itemBuilder: (_, i) {
                          return customViews(snap.data?[i]);
                        },
                      );
                    }
                    return FadingText('Loading...');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customViews(DepositTnxModel? doc) {
    const IconData check = IconData(0xe156, fontFamily: 'MaterialIcons');
    DateTime date = DateTime.parse(doc!.createdAt!);
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 20,
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Tnx Id- ${doc.id}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
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
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Amount : " + "${doc.amount}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Expanded(
                //   child: SizedBox(
                //     width: 1,
                //   ),
                // ),
                //Text("${doc!.collectorId}"),

                Flexible(
                  child: Container(
                    //color: Colors.amber,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                //child: Text(name.toString())),
                                child: RichText(
                                  text: TextSpan(
                                    text: doc.currentStatus == 0
                                        ? "Status: pending"
                                        : "Status: succes",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                child: CircleAvatar(
                                  backgroundColor: doc.currentStatus == 0
                                      ? Colors.red
                                      : Colors.green,
                                  child: Icon(
                                    doc.currentStatus == 0
                                        ? Icons.watch_later
                                        : check,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            //child: Text(name.toString())),
                            child: RichText(
                              text: TextSpan(
                                text: "Date : " +
                                    "${date.day}-${date.month}-${date.year}",
                                style: TextStyle(
                                  fontSize: 14,
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
        ]),
      ),
    );
  }
}
