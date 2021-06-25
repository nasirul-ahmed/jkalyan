import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';
import 'package:devbynasirulahmed/services/providers/auth_provider.dart';
import 'package:devbynasirulahmed/widgets/responsive_layout.dart';
import 'package:devbynasirulahmed/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  Future<dynamic?> handlePress(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("hello");
    const url = "$janaklyan/api/collector/login";
    //const url = "https://janakalyan-ag.herokuapp.com/api/collector/login";

    try {
      print(_email.text);
      print(_password.text);

      var res = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Accept": "*/*",
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, String>{
          "email": "${_email.text}",
          "password": "${_password.text}"
        }),
      );

      print(res.statusCode);

      if (200 == res.statusCode) {
        print(res.body.toString());
        Map<String, dynamic> token = jsonDecode(res.body);
        if (token.isNotEmpty) {
          //context.read(authProvider).isLogin(true);
          await pref.setString('token', token["token"]);
          await pref.setBool('isLogged', true);
          await pref.setInt('collectorId', token["id"]);
          //await pref.setString('name', token["name"]);
          await pref.setString('email', token["email"]);

          //final auth = watch(authProvider).state;
          //context.read(authProvider).state = true;
          // Provider.of<AuthNotifier>(context, listen: false).isLogin();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => DashBoard()), (route) => false);
        }

        // print(token);
        // return token;
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Responsivelayout(
      mobileView: mobileLoginUi(context),
      //desktopView: desktopLoginUi(context),
    ));
  }

  Widget mobileLoginUi(BuildContext context) {
    return isLoading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                strokeWidth: 3,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Logging',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        : new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        labelText: 'Email',
                        labelStyle:
                            TextStyle(color: Colors.black, letterSpacing: 3),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                              style: BorderStyle.none),
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
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        //errorText: errorMsg ? 'Invalid Email and password' : null,
                        errorStyle: TextStyle(color: Colors.red),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          letterSpacing: 3,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
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
}
