import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:devbynasirulahmed/screen/index.dart';
import 'package:devbynasirulahmed/services/last_customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => LastCustomerAddedService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(
    ProviderScope(
      child: CheckInternetConnection(),
    ),
  );
}

class CheckInternetConnection extends StatefulWidget {
  @override
  _CheckInternetConnectionState createState() =>
      _CheckInternetConnectionState();
}

class _CheckInternetConnectionState extends State<CheckInternetConnection> {
  bool? isConnected;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    initConnection();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(updateConnectionResult);
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  Future<void> initConnection() async {
    ConnectivityResult result = ConnectivityResult.none;

    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }
    return updateConnectionResult(result);
  }

  Future<void> updateConnectionResult(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.mobile:
        setState(() {
          isConnected = true;
        });
        break;
      case ConnectivityResult.wifi:
        setState(() {
          isConnected = true;
        });
        break;
      case ConnectivityResult.none:
        setState(() {
          isConnected = false;
        });

        break;
      default:
        setState(() {
          isConnected = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isConnected == true
        ? Index()
        : MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.red,
              body: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.wifi_off_sharp,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text('No Internet Connection',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
