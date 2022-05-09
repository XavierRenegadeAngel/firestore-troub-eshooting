import 'package:firestore_troubleshooting/database/database.dart';
import 'package:firestore_troubleshooting/models/main_topic.dart';
import 'package:flutter/material.dart';

class MainTopicExpansionTile extends StatefulWidget {
  const MainTopicExpansionTile(
      {Key? key, required this.mainTopic, required this.database})
      : super(key: key);
  final MainTopic mainTopic;
  final Database database;

  @override
  State<MainTopicExpansionTile> createState() => _MainTopicExpansionTileState();
}

class _MainTopicExpansionTileState extends State<MainTopicExpansionTile> {
  final TextEditingController _subTopicFieldController =
      TextEditingController();

  @override
  void dispose() {
    //Make sure you dispose your TextEditingControllers, FocusNodes etc.  For
    //more info check the docs for TextEditingController.
    _subTopicFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.mainTopic.docID),
      onDismissed: (direction) async {
        await widget.database.deleteMainTopic(mainTopic: widget.mainTopic);
      },
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(widget.mainTopic.name),
        children: [
          Row(children: [
            Expanded(
              child: TextField(
                controller: _subTopicFieldController,
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
          // StreamBuilder(
          //     stream: class2Stream,
          //     builder: (context, class2Snapshot) {
          //       if (class2Snapshot.hasError) {
          //         return const Text(
          //             'client snapshot has error');
          //       }
          //       if (class2Snapshot.connectionState ==
          //           ConnectionState.waiting) {
          //         return const CircularProgressIndicator();
          //       }
          //       class2Data = class2Snapshot.requireData;
          //       return ListView.builder(
          //           shrinkWrap: true,
          //           itemCount: class2Data.size,
          //           itemBuilder: (context, class2_index) {
          //             return ExpansionTile(
          //               initiallyExpanded: false,
          //               title: const Text('expansion tile 2'),
          //               children: [
          //                 ListView.builder(
          //                     shrinkWrap: true,
          //                     itemBuilder: (context, index3) {
          //                       return const ListTile(
          //                         title: Text('List tile'),
          //                       );
          //                     })
          //               ],
          //             );
          //           });
          //     })
        ],
      ),
    );
  }
}
