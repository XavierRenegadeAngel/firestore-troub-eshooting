import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_troubleshooting/services/auth_service.dart';
import 'package:firestore_troubleshooting/widgets/add_main_topic.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/sub_topic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AuthService().getOrCreateUser();
  runApp(const MyApp());
}

late var class1Data;
late var class2Data;

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController1 = TextEditingController();
  final Stream<QuerySnapshot> class1Stream = FirebaseFirestore.instance
      .collection('users')
      .doc(AuthService().currentUser?.uid)
      .collection('Class 1 Objects')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(widget.title),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(40.0),

        child: AddMainTopic())
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(
                  stream: class1Stream,
                  builder: (context, class1Snapshot) {
                    if (class1Snapshot.hasError) {
                      return const Text('client snapshot has error');
                    }
                    if (class1Snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    class1Data = class1Snapshot.requireData;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: class1Data.size,
                        itemBuilder: (context, class1_index) {
                          final Stream<QuerySnapshot> class2Stream =
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(AuthService().currentUser?.uid)
                                  .collection('Class 1 Objects')
                                  .doc(class1Data.docs[class1_index]['docID'])
                                  .collection('Class 2 Objects')
                                  .snapshots();
                          return class1Data.size > 0
                              ? ExpansionTile(
                                  initiallyExpanded: true,
                                  title:
                                      Text(class1Data.docs[class1_index]['name']),
                                  children: [
                                    Row(children: [
                                      Expanded(
                                        child: TextField(
                                          controller: textController1,
                                        ),
                                      ),
                                      Expanded(
                                          child: ElevatedButton(
                                              onPressed: () {
                                                createClass2Object(
                                                    textController1.text,
                                                    class1_index);
                                                textController1.clear();
                                                setState(() {});
                                              },
                                              child: const Text('Add Object')))
                                    ]),
                                    StreamBuilder(
                                        stream: class2Stream,
                                        builder: (context, class2Snapshot) {
                                          if (class2Snapshot.hasError) {
                                            return const Text(
                                                'client snapshot has error');
                                          }
                                          if (class2Snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          }
                                          class2Data = class2Snapshot.requireData;
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: class2Data.size,
                                              itemBuilder:
                                                  (context, class2_index) {
                                                return ExpansionTile(
                                                  initiallyExpanded: false,
                                                  title: const Text('expansion tile 2'),
                                                  children: [
                                                    ListView.builder(
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index3) {
                                                          return const ListTile(
                                                            title:
                                                                Text('List tile'),
                                                          );
                                                        })
                                                  ],
                                                );
                                              });
                                        })
                                  ],
                                )
                              : const Text('no data');
                        });
                  }),
              ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text('Set State'))
            ],
          ),
        ),
      ),
    );
  }
}

void createDocument() {}
