import 'dart:convert';

import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/screen/add_customer/review_add_customer.dart';
import 'package:devbynasirulahmed/screen/add_customer/review_mobile.dart';
import 'package:devbynasirulahmed/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

class AddCustomerMV extends StatefulWidget {
  @override
  _AddCustomerMVState createState() => _AddCustomerMVState();
}

class _AddCustomerMVState extends State<AddCustomerMV> {
  final _key = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController nomineeName = TextEditingController();
  TextEditingController nomineeAddress = TextEditingController();
  TextEditingController nomineePhone = TextEditingController();
  TextEditingController relation = TextEditingController();
  TextEditingController nomineeFatherName = TextEditingController();
  TextEditingController rateOfInterest = TextEditingController();
  //TextEditingController totalInstallments = TextEditingController();
  TextEditingController installmentAmount = TextEditingController();

  String agentUid = 'agent 1';
  int totalInstallments = 630;
  String accountType = '';
  String? maturityDate = '';
  int totalPrincipalAmount = 0;
  String createdAt = '';
  DateTime? mDate;

  String? dob = '';

  int nextAccountNumber = 1;
  bool isLoading = false;

  Future<Customer?> getAccountNo() async {
    Uri url = Uri.parse("https://sanchay-new.herokuapp.com/api/agents/account");
    try {
      var res = await http.get(url, headers: {"Accept": "application/json"});
      if (200 == res.statusCode) {
        // final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();

        // return parsed.map<Customer>((json) => Customer.fromJson(json));
        Map<String, dynamic> customerMap = jsonDecode(res.body);
        var customer = Customer.fromJson(customerMap);
        print(customer.accountNumber.toString());
        return customer;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future<void> _selectMaturityDate(BuildContext context) async {
    //   final DateTime? picked = await showDatePicker(
    //       context: context,
    //       initialDate: DateTime.now(),
    //       firstDate: DateTime(2015, 8),
    //       lastDate: DateTime(2101));
    //   setState(() {
    //     maturityDate = "${picked!.year}-${picked.month}-${picked.day}";
    //   });
    // }

    Future<void> _selectDOB(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null) {
        setState(() {
          dob = "${picked.year}-${picked.month}-${picked.day}";
        });
      }
    }

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _key,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Customer\'s Basic Details',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                customTextField('Customer Name', TextInputType.text, name),
                SizedBox(
                  height: 8,
                ),
                customTextField('Father Name', TextInputType.text, fatherName),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: InkWell(
                    onTap: () => _selectDOB(context),
                    child: IgnorePointer(
                      child: TextField(
                        //controller: maturityDate,
                        decoration: InputDecoration(
                          labelText: dob!.isEmpty ? 'Date of Birth' : dob,
                          hintText: (dob ?? '2019-12-23'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                customTextField('Address', TextInputType.text, address),
                SizedBox(
                  height: 8,
                ),
                customTextField('Pin Code', TextInputType.number, pinCode),
                SizedBox(
                  height: 8,
                ),
                customTextField('Phone/Mobile', TextInputType.phone, phone),
                SizedBox(
                  height: 8,
                ),
                customTextField('Occupation', TextInputType.text, occupation),
                SizedBox(
                  height: 8,
                ),
                customTextField(
                    'Nominee Name', TextInputType.text, nomineeName),
                SizedBox(
                  height: 8,
                ),
                customTextField(
                    'Nominee Address', TextInputType.text, nomineeAddress),
                SizedBox(
                  height: 8,
                ),
                customTextField(
                    'Nominee Phone', TextInputType.phone, nomineePhone),
                SizedBox(
                  height: 8,
                ),
                customTextField('Relation', TextInputType.text, relation),
                SizedBox(
                  height: 8,
                ),
                customTextField('Nominee Father\'s Name', TextInputType.text,
                    nomineeFatherName),
                SizedBox(
                  height: 8,
                ),
                customTextField(
                    'Rate of Interst', TextInputType.number, rateOfInterest),
                SizedBox(
                  height: 8,
                ),
                // customTextField(
                //     'No. of Installments', TextInputType.number, totalInstallments),
                // SizedBox(
                //   height: 8,
                // ),
                customTextField('Installment Amounts', TextInputType.number,
                    installmentAmount),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: DropdownButtonFormField<String>(
                    onChanged: (type) {
                      setState(() {
                        accountType = type ?? 'daily';
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    hint: Text('Account Type'),
                    isExpanded: true,
                    isDense: true,
                    items: [
                      DropdownMenuItem(
                        value: 'daily',
                        child: Text('Daily'),
                      ),
                      DropdownMenuItem(
                        value: 'weekly',
                        child: Text('Weekly'),
                      ),
                      DropdownMenuItem(
                        value: 'monthly',
                        child: Text('Monthly'),
                      ),
                    ],
                    autofocus: true,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20, right: 20),
                //   child: InkWell(
                //     onTap: () => _selectMaturityDate(context),
                //     child: IgnorePointer(
                //       child: TextField(
                //         //controller: maturityDate,
                //         decoration: InputDecoration(
                //           labelText:
                //               maturityDate!.isEmpty ? 'Maturity Date' : maturityDate,
                //           hintText: (maturityDate ?? '2021-03-19'),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Material(
                    color: Colors.teal[700],
                    borderRadius: BorderRadius.circular(30.0),
                    elevation: 5.0,
                    child: MaterialButton(
                      //color: Colors.teal,
                      onPressed: () async {
                        // setState(() {
                        //   isLoading = true;
                        // });

                        //print(customerMap);

                        DateTime creationDate = DateTime.now();

                        setState(() {
                          createdAt =
                              "${creationDate.year}-${creationDate.month}-${creationDate.day}";
                          mDate = DateTime(creationDate.year,
                              creationDate.month + 21, creationDate.day);
                        });
                        print(mDate.toString());

                        if (_key.currentState!.validate()) {
                          var random = new Random();
                          int accountNumber = random.nextInt(9000) + 999;

                          if ('daily' == accountType) {
                            setState(() {
                              totalPrincipalAmount =
                                  630 * int.parse(installmentAmount.text);
                              totalInstallments = 630;
                            });
                          } else if ('weekly' == accountType) {
                            setState(() {
                              totalPrincipalAmount =
                                  90 * int.parse(installmentAmount.text);
                              totalInstallments = 90;
                            });
                          } else {
                            setState(() {
                              totalPrincipalAmount =
                                  21 * int.parse(installmentAmount.text);
                              totalInstallments = 21;
                            });
                          }

                          maturityDate =
                              '${mDate!.year}-${mDate!.month}-${mDate!.day} ';

                          // int totalPrincipalAmount =
                          //     (int.parse(totalInstallments.text.trim()) *
                          //         int.parse(installmentAmount.text.trim()));
                          double totalInterestAmount = totalPrincipalAmount *
                              (int.parse(rateOfInterest.text) / 100);
                          double totalMaturityAmount =
                              totalPrincipalAmount + totalInterestAmount;

                          // String createdAt =
                          //     "${creationDate.year}-${creationDate.month}-${creationDate.day}";
                          // print(createdAt);

                          // setState(() {
                          //   isLoading = false;
                          // });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewMobile(
                                name.text,
                                accountNumber,
                                fatherName.text,
                                address.text,
                                int.parse(pinCode.text),
                                occupation.text,
                                nomineeName.text,
                                nomineeAddress.text,
                                int.parse(nomineePhone.text),
                                relation.text,
                                nomineeFatherName.text,
                                int.parse(rateOfInterest.text),
                                totalInstallments,
                                int.parse(installmentAmount.text),
                                maturityDate!,
                                totalPrincipalAmount,
                                totalInterestAmount,
                                totalMaturityAmount,
                                agentUid,
                                int.parse(phone.text),
                                accountType,
                                dob!,
                                createdAt,
                              ),
                            ),
                          );
                        }
                      },
                      minWidth: 200.0,
                      height: 60.0,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
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
}

// Widget AddCustomeMV(context, VoidCallback onPressed) {
  
//   //

  
// }
