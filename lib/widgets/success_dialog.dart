import 'package:flutter/material.dart';

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
