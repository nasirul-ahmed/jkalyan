import 'package:devbynasirulahmed/screen/add_customer/review_add_customer.dart';
import 'package:devbynasirulahmed/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AddCustomerDV extends StatefulWidget {
  @override
  _AddCustomerDVState createState() => _AddCustomerDVState();
}

class _AddCustomerDVState extends State<AddCustomerDV> {
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
  TextEditingController totalInstallments = TextEditingController();
  TextEditingController installmentAmount = TextEditingController();

  String agentUid = 'agent 1';
  String accountType = '';
  String? maturityDate = '';
  String createdAt = '';
  DateTime? mDate;

  String? dob = '';
  @override
  Widget build(BuildContext context) {
    Future<void> _selectMaturityDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      setState(() {
        maturityDate = "${picked!.year}-${picked.month}-${picked.day}";
      });
    }

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

    return Form(
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
          customTextField('Nominee Name', TextInputType.text, nomineeName),
          SizedBox(
            height: 8,
          ),
          customTextField(
              'Nominee Address', TextInputType.text, nomineeAddress),
          SizedBox(
            height: 8,
          ),
          customTextField('Nominee Phone', TextInputType.phone, nomineePhone),
          SizedBox(
            height: 8,
          ),
          customTextField('Relation', TextInputType.text, relation),
          SizedBox(
            height: 8,
          ),
          customTextField(
              'Nominee Father\'s Name', TextInputType.text, nomineeFatherName),
          SizedBox(
            height: 8,
          ),
          customTextField(
              'Rate of Interst', TextInputType.number, rateOfInterest),
          SizedBox(
            height: 8,
          ),
          customTextField(
              'No. of Installments', TextInputType.number, totalInstallments),
          SizedBox(
            height: 8,
          ),
          customTextField(
              'Installment Amounts', TextInputType.number, installmentAmount),
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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: InkWell(
              onTap: () => _selectMaturityDate(context),
              child: IgnorePointer(
                child: TextField(
                  //controller: maturityDate,
                  decoration: InputDecoration(
                    labelText:
                        maturityDate!.isEmpty ? 'Maturity Date' : maturityDate,
                    hintText: (maturityDate ?? '2021-03-19'),
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
                  //debugPrint(nomineeName.text);
                  // print(totalPrincipalAmount.toString());
                  if (_key.currentState!.validate()) {
                    DateTime creationDate = DateTime.now();
                    setState(() {
                      createdAt =
                          "${creationDate.year}-${creationDate.month}-${creationDate.day}";
                      mDate = DateTime(creationDate.year,
                          creationDate.month + 21, creationDate.day);
                    });
                    print(mDate.toString());
                    var random = new Random();
                    int accountNumber = random.nextInt(9000) + 999;

                    int totalPrincipalAmount =
                        (int.parse(totalInstallments.text.trim()) *
                            int.parse(installmentAmount.text.trim()));
                    double totalInterestAmount = totalPrincipalAmount *
                        (int.parse(rateOfInterest.text) / 100);
                    double totalMaturityAmount =
                        totalPrincipalAmount + totalInterestAmount;

                    print(createdAt);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewAddCustomer(
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
                          int.parse(totalInstallments.text),
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
