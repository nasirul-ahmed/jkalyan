import 'dart:io';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/api_response.dart';
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/screen/add_customer/editable_details_mobile.dart';
import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';
import 'package:devbynasirulahmed/services/add_customer_service.dart';
import 'package:devbynasirulahmed/services/date.format.dart';
import 'package:devbynasirulahmed/services/last_customer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:http_parser/http_parser.dart';

class ReviewMobile extends StatefulWidget {
  ReviewMobile(
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
    this.nomineeAge,
    this.rateOfInterest,
    this.totalInstallments,
    this.installmentAmount,
    this.maturityDate,
    this.totalPrincipalAmount,
    this.totalInterestAmount,
    this.totalMaturityAmount,
    this.phone,
    this.accountType,
    this.age,
    this.createdAt,
    this.depositAmount,
    this.file1,
    this.file2,
  );

  final String name;

  final String fatherName;
  final String address;
  final int pinCode;
  final String occupation;
  final String nomineeName;
  final String nomineeAddress;
  final int nomineePhone;

  final String relation;
  final String nomineeFatherName;
  final int nomineeAge;
  final int rateOfInterest;
  final int totalInstallments;
  final int installmentAmount;
  final String maturityDate;
  final int totalPrincipalAmount;
  final double totalInterestAmount;
  final double totalMaturityAmount;

  final int phone;
  final String accountType;
  final String age;
  final String createdAt;
  final int depositAmount;

  File file1, file2;

  @override
  _ReviewMobileState createState() => _ReviewMobileState();
}

class _ReviewMobileState extends State<ReviewMobile> {
  LastCustomerAddedService get service => GetIt.I<LastCustomerAddedService>();
  ApiResponse<Customer>? _apiResponse;
  bool isLoading = false;
  int? accountNumber = 1000001;

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
    //print(nextAccountNumber.toString());

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
                  EditableDetailsMobile(
                      'Account Number', (accountNumber ?? 0) + 1),
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
                  EditableDetailsMobile('Nominee Age', widget.nomineeAge),
                  EditableDetailsMobile(
                      'Rate of Interest', widget.rateOfInterest),
                  EditableDetailsMobile(
                      'Total Installments', widget.totalInstallments),
                  EditableDetailsMobile(
                      'Installment Amount', widget.installmentAmount),

                  EditableDetailsMobile(
                      'Principal Amount', widget.totalPrincipalAmount),
                  EditableDetailsMobile(
                      'Interest Amount', widget.totalInterestAmount),
                  EditableDetailsMobile(
                      'Maturity Amount', widget.totalMaturityAmount),
                  EditableDetailsMobile('Age', widget.age),
                  EditableDetailsMobile('Account Type', widget.accountType),
                  EditableDetailsMobile(
                      'Created At', formatDate(widget.createdAt)),
                  EditableDetailsMobile(
                      'Maturity Date', formatDate(widget.maturityDate)),
                  //EditableDetailsMobile('First Deposit', widget.depositAmount),
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
                            color: Colors.blueAccent[700],
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              Customer customer = await createCustomer(
                                (accountNumber ?? 0) + 1,
                                widget.name,
                                widget.fatherName,
                                widget.address,
                                widget.pinCode,
                                widget.phone,
                                widget.occupation,
                                widget.age,
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
                                widget.accountType,
                                widget.nomineeAge,
                                widget.depositAmount,
                              );

                              Fluttertoast.showToast(
                                msg:
                                    "Customer Added, A/c: ${customer.accountNumber}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );

                              uploadPhoto(
                                  widget.file1, customer.accountNumber!, true);
                              uploadPhoto(
                                  widget.file2, customer.accountNumber!, false);
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashBoard()),
                                  (route) => false);
                            },
                            child: Text(
                              'Submit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
      ),
    );
  }

  uploadPhoto(File _image, int accountNumber, bool isProfile) async {
    Dio dio = Dio();
    String uri = isProfile
        ? '$janaklyan/api/collector/uploads-profile'
        : "$janaklyan/api/collector/uploads-signature";
    String filename = _image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(_image.path,
          filename: filename, contentType: MediaType("image", "png")),
      "accountNumber": accountNumber,
    });

    try {
      var res = await dio.post(uri,
          data: formData,
          options: Options(sendTimeout: 60000, method: "POST", headers: {
            "Accept": "*/*",
            "Content-Type": "multipart/form-data",
          }));

      if (200 == res.statusCode) {
        print(res.data);

        Fluttertoast.showToast(
          msg: isProfile ? "Profile Uploaded" : "Signature Uploaded",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
