import 'package:devbynasirulahmed/screen/index.dart';
import 'package:devbynasirulahmed/services/last_customer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => LastCustomerAddedService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      child: Index(),
    ),
  );
}
