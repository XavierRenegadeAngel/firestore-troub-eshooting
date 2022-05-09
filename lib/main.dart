import 'package:firestore_troubleshooting/pages/my_home_page.dart';
import 'package:firestore_troubleshooting/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AuthService().getOrCreateUser();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.grey[800],
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
        splashColor: Colors.grey[800],
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Firestore Troubleshooting'),
    );
  }
}

