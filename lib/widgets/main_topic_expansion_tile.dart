import 'package:firestore_troubleshooting/database/database.dart';
import 'package:firestore_troubleshooting/models/main_topic.dart';
import 'package:firestore_troubleshooting/models/sub_topic.dart';
import 'package:firestore_troubleshooting/widgets/add_topic_field_widget.dart';
import 'package:firestore_troubleshooting/widgets/sub_topic_expansion_tile.dart';
import 'package:flutter/material.dart';

class MainTopicExpansionTile extends StatelessWidget {
  const MainTopicExpansionTile(
      {Key? key, required this.mainTopic, required this.database})
      : super(key: key);
  final MainTopic mainTopic;
  final Database database;



  @override
  Widget build(BuildContext context) {
    return Dismissible(
      //Always add a uniq Key for dismissible, or it will not work well.
      key: Key(mainTopic.docID),
      onDismissed: (direction) async {
        await database.deleteMainTopic(mainTopic: mainTopic);
      },
      child: ExpansionTile(
        leading: const Icon(Icons.view_headline_rounded),
        tilePadding: const EdgeInsets.all(8.0),
        childrenPadding: const EdgeInsets.only(left: 16.0),
        initiallyExpanded: false,
        title: Text(mainTopic.name),
        children: [
          AddTopicFieldWidget(
              onPressed: (subTopicName) {
                database.setSubTopic(
                  mainTopic: mainTopic,
                  subTopic: SubTopic(
                      name: subTopicName,
                      docID: DateTime.now().toIso8601String()),
                );
              },
              buttonText: 'Add subtopic'),
          StreamBuilder<List<SubTopic>>(
            stream:
                database.subTopicsStream(mainTopic: mainTopic),
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
                  return SubTopicExpansionTile(
                    subTopic: subTopic,
                    database: database,
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
