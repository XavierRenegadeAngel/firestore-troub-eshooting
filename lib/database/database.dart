import 'package:firestore_troubleshooting/models/main_topic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sub_topic.dart';

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
       // final docID = docSnapshot.id;
        final mainTopic = MainTopic.fromJson(docData);
        return mainTopic;
      }).toList();
    });
    return mainTopicsStream;
  }

  Future<void> setMainTopic({required MainTopic mainTopic}) {
    try {
      final docReference =
          _fireStore.doc('users/$userID/Class 1 Objects/${mainTopic.docID}');
      return docReference.set(mainTopic.toJson());
    } on FirebaseException catch (error) {
      print(
          'Error setting document, ${error.code}, ${error.message}, ${error.stackTrace}');
    } on Exception catch (error) {
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
      print(
          'Error deleting document, ${error.code}, ${error.message}, ${error.stackTrace}');
    } on Exception catch (error) {
      print(error);
    }
    return Future.value();
  }

//------------------------------------------------------------------------------
  Stream<List<SubTopic>> subTopicsStream({required MainTopic mainTopic}) {
    final mainTopicDocID = mainTopic.docID;
    final subTopicsRef = _fireStore.collection(
        'users/$userID/Class 1 Objects/${mainTopicDocID}/subTopics');
    final subTopicsStream = subTopicsRef.snapshots().map((collSnapshot) {
      return collSnapshot.docs.map((docSnapshot) {
        final docData = docSnapshot.data();
        final subTopic = SubTopic.fromJson(docData);
        return subTopic;
      }).toList();
    });
    return subTopicsStream;
  }

  Future<void> setSubTopic(
      {required MainTopic mainTopic, required SubTopic subTopic}) {
    try {
      final mainTopicDocID = mainTopic.docID;
      final subTopicID = subTopic.docID;
      final docReference = _fireStore.doc(
          'users/$userID/Class 1 Objects/${mainTopicDocID}/subTopics/${subTopicID}');
      return docReference.set(subTopic.toJson());
    } on FirebaseException catch (error) {
      print(
          'Error setting document, ${error.code}, ${error.message}, ${error.stackTrace}');
    } on Exception catch (error){
      print(error);
    }
    return Future.value();
  }
}
