import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_troubleshooting/database/database.dart';
import 'package:firestore_troubleshooting/pages/my_home_page.dart';
import 'package:firestore_troubleshooting/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final User? _user = await AuthService().getOrCreateUser();
  runApp(MyApp(
    user: _user,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.user}) : super(key: key);
  final User? user;

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
      home:  MyHomePage(title: 'Firestore Troubleshooting', database: Database(userID: user?.uid??''),),
    );
  }
}
