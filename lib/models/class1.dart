
class Class1 {
  late var name;
  late var docID;
  Class1({required this.name, required this.docID});

  Map<String, dynamic> toJson() => {'name': name, 'docID': docID};
  Class1 fromJson(Map<String, dynamic> json) =>
      Class1(name: ['name'], docID: ['docID']);
}


