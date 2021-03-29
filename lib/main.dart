import 'package:devbynasirulahmed/screen/index.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:devbynasirulahmed/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MultiProvider(
      providers: [
        new Provider<AuthServices>(
          create: (_) => AuthServices(FirebaseAuth.instance),
        ),
        new StreamProvider(
          initialData: null,
          create: (context) => context.read<AuthServices>().authStateChanges,
        )
      ],
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        //title: 'Majoni Sanchay',
        home: Index(),
        // routes: {

        // },
      ),
    );
  }
}
