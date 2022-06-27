import 'dart:io';

import 'package:devbynasirulahmed/screen/add_customer/review_mobile.dart';
import 'package:devbynasirulahmed/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class AddCustomerMV extends StatefulWidget {
  AddCustomerMV({Key? key, this.file1, this.file2}) : super(key: key);

  File? file1, file2;

  @override
  State<AddCustomerMV> createState() => _AddCustomerMVState();
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
  TextEditingController nomineeAge = TextEditingController();
  TextEditingController installmentAmount = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController depositAmount = TextEditingController();

  int totalPrincipalAmount = 0;
  int totalInstallments = 630;
  double interestAmount = 0;
  double totalMaturityAmount = 0;
  String accountType = 'daily';
  String maturityDate = '';
  String createdAt = '';
  int rateOfInterest = 0;
  String? dob = '';

  bool isLoading = false;

  Future<void> handleClick(BuildContext context) async {
    if (_key.currentState!.validate()) {
      print('createdAt: ' + createdAt);
      setState(() {
        isLoading = true;
      });

      setState(() {
        totalPrincipalAmount =
            totalInstallments * int.parse(installmentAmount.text);
      });
      setState(() {
        interestAmount = totalPrincipalAmount * rateOfInterest / 100;
      });

      setState(() {
        maturityDate = DateTime.now()
            .add(Duration(days: accountType == "yearly" ? 360 : 630))
            .toString();
      });

      setState(() {
        totalMaturityAmount = totalPrincipalAmount + interestAmount;
      });

      setState(() {
        isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewMobile(
              name.text,
              fatherName.text,
              address.text,
              int.parse(pinCode.text),
              occupation.text,
              nomineeName.text,
              nomineeAddress.text,
              int.parse(nomineePhone.text),
              relation.text,
              nomineeFatherName.text,
              int.parse(nomineeAge.text),
              rateOfInterest,
              totalInstallments,
              int.parse(installmentAmount.text),
              maturityDate,
              totalPrincipalAmount,
              interestAmount,
              totalMaturityAmount,
              int.parse(phone.text),
              accountType,
              age.text,
              createdAt,
              0,
              widget.file1!,
              widget.file2!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _selectCreatedAt(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        setState(() {
          createdAt = picked.toString();
        });
      }
    }

    return Scaffold(
      body: isLoading
          ? Center(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _key,
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
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
                  customTextField(
                      'Father Name', TextInputType.text, fatherName),
                  SizedBox(
                    height: 8,
                  ),
                  customTextField('Age', TextInputType.number, age),
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
                      'Nominee Age', TextInputType.text, nomineeAge),
                  SizedBox(
                    height: 8,
                  ),
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
                          switch (type) {
                            case "daily":
                              accountType = type ?? "daily";
                              rateOfInterest = 10;
                              totalInstallments = 630;
                              break;
                            case "weekly":
                              accountType = type ?? "weekly";
                              rateOfInterest = 9;
                              totalInstallments = 90;
                              break;
                            case "monthly":
                              accountType = type ?? "monthly";
                              rateOfInterest = 8;
                              totalInstallments = 21;
                              break;
                            case "yearly":
                              accountType = type ?? "yearly";
                              rateOfInterest = 4;
                              totalInstallments = 360;
                              break;
                          }
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
                        DropdownMenuItem(
                          value: 'yearly',
                          child: Text('Yearly'),
                        ),
                      ],
                      autofocus: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: InkWell(
                      onTap: () => _selectCreatedAt(context),
                      child: IgnorePointer(
                        child: TextField(
                          //controller: maturityDate,
                          decoration: InputDecoration(
                            labelText:
                                createdAt.isEmpty ? 'Created At' : createdAt,
                            hintText: (createdAt),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Material(
                      color: Colors.teal[700],
                      borderRadius: BorderRadius.circular(30.0),
                      elevation: 5.0,
                      child: MaterialButton(
                        //color: Colors.teal,
                        onPressed: () {
                          handleClick(context);
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
            ),
    );
  }
}
