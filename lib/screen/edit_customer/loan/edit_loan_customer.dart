import 'package:devbynasirulahmed/models/api_response.dart';
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:devbynasirulahmed/models/loan_customer.dart';
import 'package:devbynasirulahmed/screen/add_customer/add_loan/review_loan.dart';
import 'package:devbynasirulahmed/screen/edit_customer/loan/review_edit_loan.dart';
import 'package:devbynasirulahmed/services/last_customer.dart';
import 'package:devbynasirulahmed/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditLoanCustomer extends StatefulWidget {
  EditLoanCustomer(this.doc);
  final LoanCustomer doc;
  static final id = "EditLoanCustomer";
  @override
  _EditLoanCustomerState createState() => _EditLoanCustomerState();
}

class _EditLoanCustomerState extends State<EditLoanCustomer> {
  final _key = GlobalKey<FormState>();
  TextEditingController rateOfInterest = TextEditingController();
  TextEditingController installmentAmount = TextEditingController();

  String accountType = '';
  String maturityDate = '';
  int? totalInstallments;
  int payableAmount = 0;
  double totalInterestAmount = 0;
  double totalMaturityAmount = 0;

  DateTime? mDate;

  getDetails() {
    DateTime creationDate = DateTime.now();
    setState(() {
      mDate = DateTime(
          creationDate.year, creationDate.month + 21, creationDate.day);
    });

    // var random = new Random();
    // int accountNumber = random.nextInt(9000) + 999;

    if ('daily' == accountType) {
      setState(() {
        payableAmount = 630 * int.parse(installmentAmount.text);
        totalInstallments = 630;
      });
    } else if ('weekly' == accountType) {
      setState(() {
        payableAmount = 90 * int.parse(installmentAmount.text);
        totalInstallments = 90;
      });
    } else {
      setState(() {
        payableAmount = 21 * int.parse(installmentAmount.text);
        totalInstallments = 21;
      });
    }

    maturityDate = '${mDate!.year}-${mDate!.month}-${mDate!.day} ';

    totalInterestAmount =
        payableAmount * (int.parse(rateOfInterest.text) / 100);
    totalMaturityAmount = payableAmount + totalInterestAmount;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.doc.accountNumber);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Edit Deposit Customer'),
        ),
        body: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Account No: ${widget.doc.accountNumber}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Flexible(
                child: customTextField(
                    'Rate of Interst', TextInputType.number, rateOfInterest),
              ),
              SizedBox(
                height: 8,
              ),
              // customTextField(
              //     'No. of Installments', TextInputType.number, totalInstallments),
              // SizedBox(
              //   height: 8,
              // ),
              Flexible(
                child: customTextField('Installment Amounts',
                    TextInputType.number, installmentAmount),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 5),
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

              Flexible(
                child: Center(
                  child: InkWell(
                    onTap: () {
                      if (_key.currentState!.validate()) {
                        getDetails();
                        print(
                            "totalPrincipalAmount" + payableAmount.toString());

                        // var doc = {
                        //   widget.doc?.accountNumber,
                        // };

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReviewEditLoan(
                              widget.doc.accountNumber,
                              accountType,
                              maturityDate,
                              totalInstallments,
                              payableAmount,
                              totalInterestAmount,
                              // totalMaturityAmount,
                              rateOfInterest.text,
                              installmentAmount.text,
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.red.shade600,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
