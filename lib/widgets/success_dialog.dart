import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<void> showErrorDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
            title: Text('Error'),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              )
            ],
            content: Text('Something wrong'));
      });
}

Future<void> successDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        content: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width - 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.checkCircle),
              SizedBox(
                height: 10,
              ),
              Text('Success'),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              //callback!();
            },
            child: Text('Ok'),
          )
        ],
      );
    },
  );
}

Future<void> showLoadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        content: SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width - 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Loading...'),
              SizedBox(
                height: 30,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                strokeWidth: 5.0,
              ),
            ],
          ),
        ),
      );
    },
  );
}
