
class MainTopic {
  final String name;
  final String docID;
  MainTopic({required this.name, required this.docID});

  Map<String, dynamic> toJson() => {'name': name, 'docID': docID};
 static  MainTopic fromJson(Map<String, dynamic> json) =>
      MainTopic(name: json['name'], docID: json['docID']);
}

//Make your model class fields final with explicit type name for safety reasons, harder to make mistakes.
//For example without making name field final String you could pass a List with 'name' String, but
//you wanted to pass a String from the json.

// class MainTopic {
//   late var name;
//   late var docID;
//   MainTopic({required this.name, required this.docID});
//
//   Map<String, dynamic> toJson() => {'name': name, 'docID': docID};
//   static  MainTopic fromJson(Map<String, dynamic> json) =>
//       MainTopic(name: ['name'], docID: ['docID']);
// }


