import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_troubleshooting/models/main_topic.dart';


class Database {
  final String userID;
  final _fireStore = FirebaseFirestore.instance;

  Database({required this.userID});

  Stream<List<MainTopic>> mainTopicsStream() {
    final mainTopicsRef =
        _fireStore.collection('users/$userID/Class 1 Objects');
    final mainTopicsStream = mainTopicsRef.snapshots().map((collSnapshot) {
      return collSnapshot.docs.map((docSnapshot) {
        final docData = docSnapshot.data();
        final mainTopic = MainTopic.fromJson(docData);
        return mainTopic;
      }).toList();
    });
    return mainTopicsStream;
  }

  Future<void> setMainTopic({required MainTopic mainTopic}) {
    try {
      final docReference =
          _fireStore.doc('users/$userID/Class 1 Objects/${mainTopic.name}');
      return docReference.set(mainTopic.toJson());
    } on FirebaseException catch (error) {
        print('Error setting document, ${error.code}, ${error.message}, ${error.stackTrace}');
    } on Exception catch (error){
      print(error);
    }
    return Future.value();
  }

  Future<void> deleteMainTopic({required MainTopic mainTopic}) async {
    try {
      final docReference =
      _fireStore.doc('users/$userID/Class 1 Objects/${mainTopic.docID}');
      await docReference.delete();
      print('Deleted doc: ${docReference.path}');
    } on FirebaseException catch (error) {
      print('Error deleting document, ${error.code}, ${error.message}, ${error.stackTrace}');
    } on Exception catch (error){
      print(error);
    }
    return Future.value();
  }
}
