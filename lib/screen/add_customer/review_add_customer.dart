// import 'package:devbynasirulahmed/screen/add_customer/editable_details.dart';
// import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';
// import 'package:devbynasirulahmed/services/add_customer_service.dart';
// import 'package:devbynasirulahmed/widgets/max_width_container.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class ReviewAddCustomer extends StatefulWidget {
//   ReviewAddCustomer(
//       this.name,
//       this.accountNumber,
//       this.fatherName,
//       this.address,
//       this.pinCode,
//       this.occupation,
//       this.nomineeName,
//       this.nomineeAddress,
//       this.nomineePhone,
//       this.relation,
//       this.nomineeFatherName,
//       this.rateOfInterest,
//       this.totalInstallments,
//       this.installmentAmount,
//       this.maturityDate,
//       this.totalPrincipalAmount,
//       this.totalInterestAmount,
//       this.totalMaturityAmount,
//       this.agentUid,
//       this.phone,
//       this.accountType,
//       this.dob,
//       this.createdAt);

//   final String name;
//   final int accountNumber;
//   final String fatherName;
//   final String address;
//   final int pinCode;
//   final String occupation;
//   final String nomineeName;
//   final String nomineeAddress;
//   final int nomineePhone;
//   final String relation;
//   final String nomineeFatherName;
//   final int rateOfInterest;
//   final int totalInstallments;
//   final int installmentAmount;
//   final String maturityDate;
//   final int totalPrincipalAmount;
//   final double totalInterestAmount;
//   final double totalMaturityAmount;
//   final String agentUid;
//   final int phone;
//   final String accountType;
//   final String dob;
//   final String createdAt;

//   @override
//   _ReviewAddCustomerState createState() => _ReviewAddCustomerState();
// }

// class _ReviewAddCustomerState extends State<ReviewAddCustomer> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MaxWidthContainer(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           child: ListView(
//             shrinkWrap: true,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.blueGrey[500],
//                 height: 110.0,
//                 child: Center(
//                   child: Text(
//                     'Review Customer\'s Details',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                       letterSpacing: 2.0,
//                     ),
//                   ),
//                 ),
//               ),
//               EditableDetails('Name', widget.name),
//               EditableDetails('Account Number', widget.accountNumber),
//               EditableDetails('Father Name', widget.fatherName),
//               EditableDetails('Address', widget.address),
//               EditableDetails('Pin', widget.pinCode),
//               EditableDetails('Phone', widget.phone),
//               EditableDetails('Occupation', widget.occupation),
//               EditableDetails('Nominee Name', widget.nomineeName),
//               EditableDetails('Nominee Address', widget.nomineeAddress),
//               EditableDetails('Nominee Phone', widget.nomineePhone),
//               EditableDetails('Relation', widget.relation),
//               EditableDetails('Nominee Father Name', widget.nomineeFatherName),
//               EditableDetails('Rate of Interest', widget.rateOfInterest),
//               EditableDetails('Total Installments', widget.totalInstallments),
//               EditableDetails('Installment Amount', widget.installmentAmount),
//               EditableDetails('Maturity Date', widget.maturityDate),
//               EditableDetails('Principal Amount', widget.totalPrincipalAmount),
//               EditableDetails('Interest Amount', widget.totalInterestAmount),
//               EditableDetails('Maturity Amount', widget.totalMaturityAmount),
//               EditableDetails('Date of Birth', widget.dob),
//               EditableDetails('Account Type', widget.accountType),
//               SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   MaterialButton(
//                     height: 50,
//                     minWidth: 240,
//                     color: Colors.blueAccent[700],
//                     onPressed: () {
//                       createCustomer(
//                         widget.accountNumber,
//                         widget.name,
//                         widget.fatherName,
//                         widget.address,
//                         widget.pinCode,
//                         widget.phone,
//                         widget.occupation,
//                         widget.dob,
//                         widget.nomineeName,
//                         widget.nomineeAddress,
//                         widget.nomineePhone,
//                         widget.relation,
//                         widget.nomineeFatherName,
//                         widget.createdAt,
//                         widget.rateOfInterest,
//                         widget.totalInstallments,
//                         widget.installmentAmount,
//                         widget.totalPrincipalAmount,
//                         widget.totalInterestAmount,
//                         widget.totalMaturityAmount,
//                         widget.maturityDate,
//                         widget.agentUid,
//                         widget.accountType,
//                       );

//                       Fluttertoast.showToast(
//                         msg: "Customer Added",
//                         toastLength: Toast.LENGTH_SHORT,
//                         gravity: ToastGravity.CENTER,
//                         timeInSecForIosWeb: 1,
//                         backgroundColor: Colors.black,
//                         textColor: Colors.white,
//                         fontSize: 16.0,
//                       );

//                       Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DashBoard(),
//                           ),
//                           (route) => false);
//                     },
//                     child: Text(
//                       'Submit',
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 30,
//                   ),
//                   MaterialButton(
//                     height: 50,
//                     minWidth: 240,
//                     color: Colors.blueGrey[300],
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Text('Edit Details'),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
