import 'package:firestore_troubleshooting/database/database.dart';
import 'package:firestore_troubleshooting/models/main_topic.dart';
import 'package:firestore_troubleshooting/models/sub_topic.dart';
import 'package:firestore_troubleshooting/widgets/add_topic_field_widget.dart';
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
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      //Always add a uniq Key for dismissible, or it will not work well.
      key: Key(widget.mainTopic.docID),
      onDismissed: (direction) async {
        await widget.database.deleteMainTopic(mainTopic: widget.mainTopic);
      },
      child: ExpansionTile(
        leading: const Icon(Icons.view_headline_rounded),
        tilePadding: const EdgeInsets.all(8.0),
        childrenPadding: const EdgeInsets.only(left: 16.0),
        initiallyExpanded: false,
        title: Text(widget.mainTopic.name),
        children: [
          AddTopicFieldWidget(
              onPressed: (subTopicName) {
                widget.database.setSubTopic(
                  mainTopic: widget.mainTopic,
                  subTopic: SubTopic(
                      name: subTopicName,
                      docID: DateTime.now().toIso8601String()),
                );
              },
              buttonText: 'Add subtopic'),
          StreamBuilder<List<SubTopic>>(
            stream:
                widget.database.subTopicsStream(mainTopic: widget.mainTopic),
            initialData: const <SubTopic>[],
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('client snapshot has error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('Empty'),
                );
              }
              final subTopicsList = snapshot.data ?? [];
              return ListView.builder(
                shrinkWrap: true,
                itemCount: subTopicsList.length,
                itemBuilder: (context, subTopicIndex) {
                  final subTopic = subTopicsList[subTopicIndex];
                  return ExpansionTile(
                    initiallyExpanded: false,
                    title: Text(subTopic.name),
                    childrenPadding: const EdgeInsets.only(left: 16.0),
                    children: [
                      ListView(shrinkWrap: true, children: const [
                        ListTile(
                          title: Text('Teszt tile'),
                        )
                      ])
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
