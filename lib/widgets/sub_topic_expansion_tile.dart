import 'package:firestore_troubleshooting/models/sub_topic.dart';
import 'package:flutter/material.dart';

import '../database/database.dart';

class SubTopicExpansionTile extends StatelessWidget {
  const SubTopicExpansionTile({Key? key, required this.subTopic, required this.database})
      : super(key: key);
  final SubTopic subTopic;
  final Database database;

  @override
  Widget build(BuildContext context) {
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
  }
}
