


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_troubleshooting/services/auth_service.dart';
import 'package:firestore_troubleshooting/widgets/add_main_topic.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late var main_topics;
  late var class2Data;

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

          bottom: PreferredSize(preferredSize: const Size.fromHeight(32.0),

              child: AddMainTopic())
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,

            children: <Widget>[
              StreamBuilder(
                  stream: class1Stream,
                  initialData: const [],
                  builder: (context, class1Snapshot) {
                    if (class1Snapshot.hasError) {
                      return const Text('client snapshot has error');
                    }
                    if (class1Snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    main_topics = class1Snapshot.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: main_topics.size,
                        itemBuilder: (context, mainTopicIndex) {

                          final Stream<QuerySnapshot> class2Stream =
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(AuthService().currentUser?.uid)
                              .collection('Class 1 Objects')
                              .doc(main_topics.docs[mainTopicIndex]['docID'])
                              .collection('Class 2 Objects')
                              .snapshots();
                          return main_topics.size > 0
                              ? ExpansionTile(
                            initiallyExpanded: true,
                            title:
                            Text(main_topics.docs[mainTopicIndex]['name']),
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
                                          // createClass2Object(
                                          //     textController1.text,
                                          //     mainTopicIndex);
                                          // textController1.clear();
                                          // setState(() {});
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
