import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';
import 'package:devbynasirulahmed/services/last_customer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:devbynasirulahmed/services/auth_service.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => LastCustomerAddedService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: DashBoard(),
    );
  }
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MultiProvider(
//       providers: [
//         new Provider<AuthServices>(
//           create: (_) => AuthServices(FirebaseAuth.instance),
//         ),
//         new StreamProvider(
//           initialData: null,
//           create: (context) => context.read<AuthServices>().authStateChanges,
//         )
//       ],
//       child: new MaterialApp(
//         debugShowCheckedModeBanner: false,
//         //title: 'Majoni Sanchay',
//         home: DashBoard(),
//         // routes: {

//         // },
//       ),
//     );
//   }
// }
