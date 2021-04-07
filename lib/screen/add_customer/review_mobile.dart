import 'dart:convert';

import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/screen/add_customer/editable_details_mobile.dart';
import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';
import 'package:devbynasirulahmed/screen/upload/upload_profile.dart';
import 'package:devbynasirulahmed/services/add_customer_service.dart';
import 'package:devbynasirulahmed/services/customer_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ReviewMobile extends StatefulWidget {
  ReviewMobile(
      this.name,
      this.accountNumber,
      this.fatherName,
      this.address,
      this.pinCode,
      this.occupation,
      this.nomineeName,
      this.nomineeAddress,
      this.nomineePhone,
      this.relation,
      this.nomineeFatherName,
      this.rateOfInterest,
      this.totalInstallments,
      this.installmentAmount,
      this.maturityDate,
      this.totalPrincipalAmount,
      this.totalInterestAmount,
      this.totalMaturityAmount,
      this.agentUid,
      this.phone,
      this.accountType,
      this.dob,
      this.createdAt);

  final String name;
  final int accountNumber;
  final String fatherName;
  final String address;
  final int pinCode;
  final String occupation;
  final String nomineeName;
  final String nomineeAddress;
  final int nomineePhone;
  final String relation;
  final String nomineeFatherName;
  final int rateOfInterest;
  final int totalInstallments;
  final int installmentAmount;
  final String maturityDate;
  final int totalPrincipalAmount;
  final double totalInterestAmount;
  final double totalMaturityAmount;
  final String agentUid;
  final int phone;
  final String accountType;
  final String dob;
  final String createdAt;

  @override
  _ReviewMobileState createState() => _ReviewMobileState();
}

class _ReviewMobileState extends State<ReviewMobile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    //print(nextAccountNumber.toString());
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blueGrey[500],
                    height: 80.0,
                    child: Center(
                      child: Text(
                        'Review Customer\'s Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ),
                  EditableDetailsMobile('Name', widget.name),
                  EditableDetailsMobile('Account Number', widget.accountNumber),
                  EditableDetailsMobile('Father Name', widget.fatherName),
                  EditableDetailsMobile('Address', widget.address),
                  EditableDetailsMobile('Pin', widget.pinCode),
                  EditableDetailsMobile('Phone', widget.phone),
                  EditableDetailsMobile('Occupation', widget.occupation),
                  EditableDetailsMobile('Nominee Name', widget.nomineeName),
                  EditableDetailsMobile(
                      'Nominee Address', widget.nomineeAddress),
                  EditableDetailsMobile('Nominee Phone', widget.nomineePhone),
                  EditableDetailsMobile('Relation', widget.relation),
                  EditableDetailsMobile(
                      'Nominee Father', widget.nomineeFatherName),
                  EditableDetailsMobile(
                      'Rate of Interest', widget.rateOfInterest),
                  EditableDetailsMobile(
                      'Total Installments', widget.totalInstallments),
                  EditableDetailsMobile(
                      'Installment Amount', widget.installmentAmount),
                  EditableDetailsMobile('Maturity Date', widget.maturityDate),
                  EditableDetailsMobile(
                      'Principal Amount', widget.totalPrincipalAmount),
                  EditableDetailsMobile(
                      'Interest Amount', widget.totalInterestAmount),
                  EditableDetailsMobile(
                      'Maturity Amount', widget.totalMaturityAmount),
                  EditableDetailsMobile('Date of Birth', widget.dob),
                  EditableDetailsMobile('Account Type', widget.accountType),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            height: 50,
                            color: Colors.blueAccent[700],
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              Customer res = await createCustomer(
                                widget.accountNumber,
                                widget.name,
                                widget.fatherName,
                                widget.address,
                                widget.pinCode,
                                widget.phone,
                                widget.occupation,
                                widget.dob,
                                widget.nomineeName,
                                widget.nomineeAddress,
                                widget.nomineePhone,
                                widget.relation,
                                widget.nomineeFatherName,
                                widget.createdAt,
                                widget.rateOfInterest,
                                widget.totalInstallments,
                                widget.installmentAmount,
                                widget.totalPrincipalAmount,
                                widget.totalInterestAmount,
                                widget.totalMaturityAmount,
                                widget.maturityDate,
                                widget.agentUid,
                                widget.accountType,
                              );

                              //Map<String, dynamic> getId = jsonDecode(res);
                              setState(() {
                                isLoading = true;
                              });

                              Fluttertoast.showToast(
                                msg: "Customer Added",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );

                              setState(() {
                                isLoading = false;
                              });

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UploadProfile(widget.accountNumber),
                                  ),
                                  (route) => false);
                            },
                            child: Text(
                              'Submit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: MaterialButton(
                            height: 50,
                            minWidth: 240,
                            color: Colors.blueGrey[300],
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Edit Details'),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }
}
