import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_troubleshooting/models/class1.dart';
import 'package:firestore_troubleshooting/services/auth_service.dart';
import 'package:flutter/material.dart';

class AddObjectClass1Field extends StatelessWidget {
  AddObjectClass1Field({Key? key}) : super(key: key);
  TextEditingController textController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textController1,
          ),
        ),
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  createClass1Object(textController1.text);
                  textController1.clear();
                },
                child: const Text('Add Object')))
      ],
    );
  }
}

Future createClass1Object(name) async {
  final class1_ref = FirebaseFirestore.instance
      .collection('users')
      .doc(AuthService().currentUser?.uid)
      .collection('Class 1 Objects')
      .doc();
  final class1Object = Class1(name: name, docID: class1_ref.id);
  final json = class1Object.toJson();
  await class1_ref.set(json);
}
