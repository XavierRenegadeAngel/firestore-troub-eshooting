import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_troubleshooting/main.dart';
import 'package:firestore_troubleshooting/services/auth_service.dart';

class Class2 {
  late var name;
  late var docID;
  Class2({required this.name, required this.docID});

  Map<String, dynamic> toJson() => {'name': name, 'docID': docID};
  Class2 fromJson(Map<String, dynamic> json) =>
      Class2(name: ['name'], docID: ['docID']);
}

Future createClass2Object(name, class1_index) async {
  final Class2_ref = FirebaseFirestore.instance
      .collection('users')
      .doc(AuthService().currentUser?.uid)
      .collection('Class 1 Objects')
      .doc(class1Data.docs[class1_index]['docID'])
      .collection('Class 2 Objects')
      .doc();

  final Class2Object = Class2(name: name, docID: Class2_ref.id);
  final json = Class2Object.toJson();
  await Class2_ref.set(json);
}
