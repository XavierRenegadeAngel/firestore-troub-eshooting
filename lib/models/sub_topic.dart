import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_troubleshooting/main.dart';
import 'package:firestore_troubleshooting/services/auth_service.dart';

class SubTopic {
  late var name;
  late var docID;
  SubTopic({required this.name, required this.docID});

  Map<String, dynamic> toJson() => {'name': name, 'docID': docID};
  SubTopic fromJson(Map<String, dynamic> json) =>
      SubTopic(name: ['name'], docID: ['docID']);
}

Future createClass2Object(name, class1_index) async {
  final Class2_ref = FirebaseFirestore.instance
      .collection('users')
      .doc(AuthService().currentUser?.uid)
      .collection('Class 1 Objects')
      .doc(class1Data.docs[class1_index]['docID'])
      .collection('Class 2 Objects')
      .doc();

  final Class2Object = SubTopic(name: name, docID: Class2_ref.id);
  final json = Class2Object.toJson();
  await Class2_ref.set(json);
}
