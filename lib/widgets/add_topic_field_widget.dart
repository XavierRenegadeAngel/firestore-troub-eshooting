import 'package:flutter/material.dart';

class AddTopicFieldWidget extends StatefulWidget {
  AddTopicFieldWidget(
      {Key? key, required this.onPressed, required this.buttonText})
      : super(key: key);
  final Function(String) onPressed;
  final String buttonText;

  @override
  State<AddTopicFieldWidget> createState() => _AddTopicFieldWidgetState();
}

class _AddTopicFieldWidgetState extends State<AddTopicFieldWidget> {
  final TextEditingController _topicNameField = TextEditingController();

  @override
  void dispose() {
    _topicNameField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: '...',
                  filled: true,
                  fillColor: Theme.of(context).primaryColor,
                  hintStyle: Theme.of(context).textTheme.subtitle1),
              controller: _topicNameField,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                widget.onPressed(_topicNameField.text);
                _topicNameField.clear();
              },
              child: Text(widget.buttonText),
            ),
          ),
        ],
      ),
    );
  }
}

// Future createClass1Object(name) async {
//   final class1_ref = FirebaseFirestore.instance
//       .collection('users')
//       .doc(AuthService().currentUser?.uid)
//       .collection('Class 1 Objects')
//       .doc();
//   final class1Object = MainTopic(name: name, docID: class1_ref.id);
//   final json = class1Object.toJson();
//   await class1_ref.set(json);
// }
