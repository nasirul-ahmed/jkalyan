import 'package:devbynasirulahmed/screen/add_customer/addDepositCustomer.dart';
import 'package:devbynasirulahmed/widgets/all_customers.dart';
import 'package:flutter/material.dart';

Widget desktopViewDashboard(BuildContext context) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
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
                  elevation: 16,
                  color: Colors.yellow[800],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Daily Deposit Collection',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '00.0',
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
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.height / 2,
                height: 150,
                //height: MediaQuery.of(context).size.width / 2,
                child: Card(
                  elevation: 16,
                  color: Colors.yellow[800],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Daily Loan Collection',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '00.0',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllCustomers(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30)),
                      color: Colors.pink[900],
                    ),
                    height: 100,
                    //color: Colors.pink[900],
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.grading_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'All Customers',
                            style: TextStyle(
                              letterSpacing: 3,
                              color: Colors.white,
                              fontSize: 22,
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
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GestureDetector(
                  // onTap: () {
                  //   Navigator.pushNamed(context, Home.id);
                  // },
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDepositCustomer()));
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(30)),
                      color: Colors.pink[900],
                    ),
                    //color: Colors.pink[900],
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.grading_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Add Custtomer',
                            style: TextStyle(
                              letterSpacing: 3,
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    ),
  );
}
