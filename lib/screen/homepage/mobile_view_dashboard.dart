import 'package:devbynasirulahmed/screen/add_customer/addDepositCustomer.dart';
import 'package:devbynasirulahmed/screen/edit_customer/edit_customer.dart';
import 'package:devbynasirulahmed/screen/upload/upload_profile.dart';
import 'package:devbynasirulahmed/widgets/all_customers.dart';
import 'package:flutter/material.dart';

Widget mobileViewDashboard(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.height / 2,
                height: 150,
                //height: MediaQuery.of(context).size.width / 2,

                child: Card(
                  elevation: 8,
                  color: Colors.pink[500],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Deposit Collection',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '₹ 00.0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.height / 2,
                height: 150,
                //height: MediaQuery.of(context).size.width / 2,
                child: Card(
                  elevation: 8,
                  color: Colors.pink[500],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Loan Collection',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '₹ 00.0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AllCustomers()));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange[800],
              borderRadius: BorderRadius.circular(6),
            ),
            height: 60,
            width: MediaQuery.of(context).size.width - 20,
            //color: Colors.orange[700],
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.grading_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'All Customer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDepositCustomer()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 60,
                    //width: MediaQuery.of(context).size.width / 2 - 16,
                    //color: Colors.pink[900],
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Add Customer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   width: 10,
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditCustomer()));
                  },
                  child: Container(
                    // width: MediaQuery.of(context).size.width / 2 - 16,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange[800],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    //color: Colors.pink[900],
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 22,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Edit Customer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // MaterialButton(
        //   onPressed: () {
        //     Navigator.of(context).push(
        //         MaterialPageRoute(builder: (context) => UploadProfile(9503)));
        //   },
        //   child: Text('upload image'),
        // )
        //Text('customer ac no: '),
      ],
    ),
  );
}
