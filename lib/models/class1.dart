import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_troubleshooting/services/auth_service.dart';

class Class1 {
  late var name;
  late var docID;
  Class1({required this.name, required this.docID});

  Map<String, dynamic> toJson() => {'name': name, 'docID': docID};
  Class1 fromJson(Map<String, dynamic> json) =>
      Class1(name: ['name'], docID: ['docID']);
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
