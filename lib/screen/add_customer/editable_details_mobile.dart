import 'package:flutter/material.dart';

Widget EditableDetailsMobile(String keyField, var value) {
  return Container(
    padding: EdgeInsets.only(left: 5, right: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                //width: MediaQuery.of(context).size.width - 20,
                height: 50,
                child: Center(
                  child: Text(
                    keyField,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                width: 200,
                height: 50,
                child: Center(
                  child: Text(
                    '$value',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
