
class MainTopic {
  late var name;
  late var docID;
  MainTopic({required this.name, required this.docID});

  Map<String, dynamic> toJson() => {'name': name, 'docID': docID};
  MainTopic fromJson(Map<String, dynamic> json) =>
      MainTopic(name: ['name'], docID: ['docID']);
}


