import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_troubleshooting/database/database.dart';
import 'package:firestore_troubleshooting/models/main_topic.dart';
import 'package:firestore_troubleshooting/services/auth_service.dart';
import 'package:firestore_troubleshooting/widgets/add_topic_field_widget.dart';
import 'package:firestore_troubleshooting/widgets/main_topic_expansion_tile.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.database})
      : super(key: key);
  final Database database;
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
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(32.0),
          child: AddTopicFieldWidget(
            onPressed: (mainTopicName) async {
              await widget.database.setMainTopic(
                mainTopic: MainTopic(
                  name: mainTopicName,
                  docID: DateTime.now().toIso8601String(),
                ),
              );
            },
            buttonText: 'Add main topic',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            StreamBuilder<List<MainTopic>>(
                stream: widget.database.mainTopicsStream(),
                initialData: const <MainTopic>[],
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('client snapshot has error');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('Empty content'),
                    );
                  }
                  final mainTopics = snapshot.data ?? [];
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: mainTopics.length,
                    itemBuilder: (context, mainTopicIndex) {
                      final mainTopic = mainTopics[mainTopicIndex];
                      return MainTopicExpansionTile(
                          mainTopic: mainTopic, database: widget.database);
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}

void createDocument() {}
