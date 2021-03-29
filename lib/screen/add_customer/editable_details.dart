import 'package:flutter/material.dart';

Widget EditableDetails(String keyField, var value) {
  return Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 50,
              child: Center(
                child: Text(
                  keyField,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              width: 70,
            ),
            Container(
              width: 200,
              height: 50,
              child: Center(
                child: Text(
                  '$value',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
