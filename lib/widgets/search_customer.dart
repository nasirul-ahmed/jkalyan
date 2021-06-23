import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:devbynasirulahmed/screen/passbook/passbook_customer.dart';
import 'package:flutter/scheduler.dart';
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:flutter/material.dart';

class SearchCustomer extends StatefulWidget {
  SearchCustomer(
      this.voidCallback1, this.voidCallback2, this.query, this.callback3);
  final TaskCallback voidCallback1;
  final TaskCallback voidCallback2;
  final String query;
  final Function(Customer?) callback3;
  @override
  _SearchCustomerState createState() => _SearchCustomerState();
}

class _SearchCustomerState extends State<SearchCustomer> {
  @override
  Widget build(BuildContext context) {
    var futureBuilder = FutureBuilder<List<Customer>>(
        future: widget.voidCallback1(),
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
                  print(snap.data?[id].profile ?? 'y');
                  Uint8List? profile =
                      Base64Decoder().convert(snap.data?[id].profile ?? '');
                  return ListTile(
                    hoverColor: Colors.grey[300],
                    leading: snap.data?[id].profile == null
                        ? CircleAvatar(
                            child: Icon(Icons.person),
                          )
                        : Container(
                            width: 40,
                            height: 40,
                            //child: Image.memory(profile),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: MemoryImage(profile),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                    onTap: () {
                      widget.callback3(snap.data?[id]);
                    },
                    title: Text(
                      '${snap.data?[id].name}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    subtitle: Text(
                      'A/c: ${snap.data?[id].accountNumber}',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Container(
                      child: Text('₹ ${snap.data?[id].totalPrincipalAmount}'),
                    ),
                  );
                });
          } else
            return Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                backgroundColor: Colors.pink,
              ),
            );
        });
    return widget.query.isNotEmpty
        ? Flexible(child: futureBuilder)
        : Flexible(
            child: FutureBuilder<List<Customer>>(
              future: widget.voidCallback2(),
              builder: (_, snap) {
                if (snap.hasError) {
                  print(snap.error);
                  return Text('Something Wrong');
                } else if (snap.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snap.data?.length,
                      itemBuilder: (__, id) {
                        Uint8List? profile = Base64Decoder()
                            .convert(snap.data?[id].profile ?? '');
                        return ListTile(
                          hoverColor: Colors.grey[300],
                          leading: snap.data?[id].profile == null
                              ? CircleAvatar(
                                  child: Icon(Icons.person),
                                )
                              : Container(
                                  width: 40,
                                  height: 40,
                                  //child: Image.memory(profile),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: MemoryImage(profile),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                          onTap: () {
                            widget.callback3(snap.data?[id]);
                          },
                          title: Text(
                            '${snap.data?[id].name}',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          subtitle: Text(
                            'A/c: ${snap.data?[id].accountNumber}',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Container(
                            child: Text(
                                '₹ ${snap.data?[id].totalPrincipalAmount}'),
                          ),
                        );
                      });
                } else {
                  return SizedBox(
                    //alignment: Alignment.center,
                    //width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.4,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          );
  }
}
