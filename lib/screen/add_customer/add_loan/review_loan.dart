import 'package:devbynasirulahmed/models/api_response.dart';
import 'package:devbynasirulahmed/models/loan_customer.dart';
import 'package:devbynasirulahmed/screen/upload/loan/loan_upload.dart';
import 'package:devbynasirulahmed/services/last_loan_customer.dart';
import 'package:devbynasirulahmed/services/loan/add_loan/create_loan_customer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

import '../editable_details_mobile.dart';

class ReviewLoan extends StatefulWidget {
  ReviewLoan(
    this.name,
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
    this.payableAmount,
    this.totalInterestAmount,
    this.loanAmount,
    this.agentUid,
    this.phone,
    this.accountType,
    this.dob,
    this.createdAt,
  );
  final name;
  final fatherName;
  final address;
  final pinCode;
  final occupation;
  final nomineeName;
  final nomineeAddress;
  final nomineePhone;
  final relation;
  final nomineeFatherName;
  final rateOfInterest;
  final totalInstallments;
  final installmentAmount;
  final payableAmount;
  final totalInterestAmount;
  final loanAmount;
  final agentUid;
  final phone;
  final accountType;
  final dob;
  final createdAt;

  @override
  _ReviewLoanState createState() => _ReviewLoanState();
}

class _ReviewLoanState extends State<ReviewLoan> {
  LastLoanCustomerAddedService get service =>
      GetIt.I<LastLoanCustomerAddedService>();
  ApiResponse<LoanCustomer>? _apiResponse;
  bool isLoading = false;
  int? accountNumber;
  @override
  void initState() {
    super.initState();
    fetchCustomer();
  }

  fetchCustomer() async {
    setState(() {
      isLoading = true;
    });

    _apiResponse = await service.getLastCustomer();

    setState(() {
      isLoading = false;
      accountNumber = _apiResponse?.data?.accountNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text('Review'),
        ),
        backgroundColor: Colors.grey[200],
        body: Builder(
          builder: (_) {
            if (isLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Generating A/c Number...',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              );
            }

            if (_apiResponse!.err!) {
              Center(
                child: Text('Something not right'),
              );
            }
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blueGrey[500],
                        height: 50.0,
                        child: Center(
                          child: Text(
                            'Review Customer\'s Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    EditableDetailsMobile('Name', widget.name),
                    // EditableDetailsMobile(
                    //     'Account Number', (accountNumber ?? 1000001) + 1),
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
                    //EditableDetailsMobile('Maturity Date', widget.maturityDate),
                    EditableDetailsMobile(
                        'Principal Amount', widget.payableAmount),
                    EditableDetailsMobile(
                        'Interest Amount', widget.totalInterestAmount),
                    // EditableDetailsMobile(
                    //     'Maturity Amount', widget.totalMaturityAmount),
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
                              minWidth: 240,
                              color: Colors.blueGrey[300],
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Edit Details',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: MaterialButton(
                              height: 50,
                              color: Colors.blueAccent[700],
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                createLoanCustomer(
                                  (accountNumber ?? 1000),
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
                                  widget.payableAmount,
                                  widget.totalInterestAmount,
                                  widget.loanAmount,
                                  widget.agentUid,
                                  widget.accountType,
                                );

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

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UploadProfileLoan(),
                                  ),
                                );
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
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
          },
        ));
  }
}
