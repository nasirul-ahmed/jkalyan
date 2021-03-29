import 'package:devbynasirulahmed/widgets/responsive_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:devbynasirulahmed/services/auth_service.dart';

// import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<dynamic> handlePress(BuildContext context) async {
    await AuthServices(FirebaseAuth.instance)
        .signIn(email: _email.text, password: _password.text);
    debugPrint(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Responsivelayout(
      mobileView: mobileLoginUi(context),
      desktopView: desktopLoginUi(context),
    ));
  }

  Widget mobileLoginUi(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Jana',
                style: TextStyle(
                  color: Colors.red,
                  letterSpacing: 5.0,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Kalayan',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 5.0,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
          ),
          new SizedBox(
            height: 50,
          ),
          new Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                cursorWidth: 2.0,
                style: TextStyle(color: Colors.black),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Required*';
                  }
                  return null;
                },
                controller: _email,
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black, letterSpacing: 3),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white, width: 2, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Reuired*';
                  }
                  return null;
                },
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: true,
                controller: _password,
                decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  //errorText: errorMsg ? 'Invalid Email and password' : null,
                  errorStyle: TextStyle(color: Colors.red),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    letterSpacing: 3,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Colors.orange[800],
            ),
            width: 150,
            child: MaterialButton(
              //focusColor: Colors.amber[700],
              //color: Colors.teal,
              onPressed: () => handlePress(context),
              minWidth: 150.0,
              height: 50.0,
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget desktopLoginUi(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Jana',
                style: TextStyle(
                  color: Colors.red,
                  letterSpacing: 5.0,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Kalayan',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 5.0,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
          ),
          new SizedBox(
            height: 50,
          ),
          new Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                cursorWidth: 2.0,
                style: TextStyle(color: Colors.black),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Required*';
                  }
                  return null;
                },
                controller: _email,
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black, letterSpacing: 3),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white, width: 2, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Reuired*';
                  }
                  return null;
                },
                enabled: true,
                style: TextStyle(color: Colors.black),
                obscureText: true,
                controller: _password,
                decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  //errorText: errorMsg ? 'Invalid Email and password' : null,
                  errorStyle: TextStyle(color: Colors.red),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    letterSpacing: 3,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Colors.teal,
            ),
            width: 150,
            child: MaterialButton(
              onPressed: () => handlePress(context),
              minWidth: 160.0,
              height: 55.0,
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
