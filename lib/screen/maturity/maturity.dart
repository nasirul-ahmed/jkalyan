import 'dart:async';
import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Maturity extends StatefulWidget {
  Maturity(this.doc);
  final Customer? doc;
  @override
  _MaturityState createState() => _MaturityState();
}

class _MaturityState extends State<Maturity> {
  TextEditingController _accountNumber = TextEditingController();
  TextEditingController _custName = TextEditingController();
  TextEditingController _maturityValue = TextEditingController();
  TextEditingController _maturityAmount = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? accountNumber;
  String? custName;
  String? maturityValue;
  String? maturityAmount;
  int maturityType = 0;
  Future<void> sendData() async {
    print(_custName.text);
    print(_accountNumber.text);
    showLoadingDialog(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt('collectorId');

    Uri url = Uri.parse("$janaklyan/api/collector/maturity-ac");

    try {
      var res = await http.post(
        url,
        body: jsonEncode(<String, dynamic>{
          "collectorId": id,
          "accountNumber": int.parse(_accountNumber.text),
          "custName": _custName.text,
          "maturityValue": _maturityValue.text,
          "maturityAmount": int.parse(_maturityAmount.text),
          "submitDate": selectedDate.toString().split(" ")[0],
          "openingDate": widget.doc!.createdAt.toString().split("T")[0],
          "fathersName": widget.doc!.fatherName,
          "address": widget.doc!.address,
          "isPreMatured": maturityType
        }),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
      );

      if (200 == res.statusCode) {
        Navigator.pop(context);
        var jsonData = jsonDecode(res.body);
        print(jsonData);
        successDialog(context);
      } else {
        Navigator.pop(context);
        showErrorDialog(context);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _accountNumber.text = widget.doc!.accountNumber.toString();
    _custName.text = widget.doc!.name.toString();
    _maturityValue.text = widget.doc!.totalPrincipalAmount.toString();
    _maturityAmount.text = widget.doc!.totalCollection.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maturity'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14),
            child: Container(
              ///padding: EdgeInsets.all(10),
              height: 50,
              width: MediaQuery.of(context).size.width - 20,
              color: Colors.blue[900],
              child: Center(
                child: Text(
                  'Account Maturity',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //details(keys, value, label, type),
          details("accountNumber", "${widget.doc!.accountNumber}", "A/c Number",
              TextInputType.number, _accountNumber),
          details("custName", "${widget.doc!.name}", "Name", TextInputType.text,
              _custName),
          details("maturityValue", "${widget.doc!.totalMaturityAmount}",
              "Scheme Value", TextInputType.number, _maturityValue),
          details(
              "maturityAmount",
              "${widget.doc!.totalCollection}",
              "Total Deposit Amount (Rs.)",
              TextInputType.number,
              _maturityAmount),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: DropdownButtonFormField<String>(
              style: TextStyle(
                  fontSize: 15, color: Colors.black, letterSpacing: 2.0),
              onChanged: (type) {
                switch (type) {
                  case "maturity":
                    {
                      setState(() {
                        maturityType = 0;
                      });
                      print("$maturityType");
                    }
                    break;
                  case "pre maturity":
                    setState(() {
                      maturityType = 1;
                    });
                    print("$maturityType");
                    break;
                  default:
                    {
                      setState(() {
                        maturityType = 0;
                      });
                    }
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              hint: Text('Maturity Type'),

              items: [
                DropdownMenuItem(
                  value: 'maturity',
                  child: Text('Maturity'),
                ),
                DropdownMenuItem(
                  value: 'pre maturity',
                  child: Text('Pre Maturity'),
                ),
              ],
              //autofocus: true,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Opening Date',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.doc!.createdAt.toString().split("T")[0]}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: InkWell(
                    onTap: () => selectDate(context, 1),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .5,
                      color: Colors.red,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              'Select Submit Date',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      selectedDate.toString().split(" ").first,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.circular(30.0),
              ),
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                onPressed: () => conFirm(),
                child: Text(
                  'Request To Mature/Pre-Mature',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Future<void> selectDate(BuildContext context, int id) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    print(selectedDate.toString());
  }

  Future<void> conFirm() {
    return showDialog(
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
                  print(_custName.text);
                  Navigator.pop(context);
                  sendData();
                },
              ),
            ],
            title: Text(
              'Do you want to proceed?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: Text('To mature A/c: ${widget.doc?.accountNumber}'),
          );
        });
  }

  Widget details(String keys, String value, String label, type,
      TextEditingController controller) {
    return Container(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          autofocus: false,
          enabled: keys == "accountNumber" || keys == "loanAccountNumber"
              ? false
              : true,
          controller: controller,
          keyboardType: type ?? null,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            focusColor: Colors.black,
            labelText: label,
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey, width: 2, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(25.0),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
          ),
        ),
      ),
    );
  }
}
