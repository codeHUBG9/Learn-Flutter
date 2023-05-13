import 'package:flutter/material.dart';

class TextInputButton extends StatefulWidget {
  final Function(String) callback;

  TextInputButton(this.callback);

  @override
  State<TextInputButton> createState() => _TextInputButtonState();
}

class _TextInputButtonState extends State<TextInputButton> {
  final controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void postMsg() {
    widget.callback(controller.text);
    FocusScope.of(context).unfocus();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
            prefix: Icon(Icons.message),
            hintText: "Type a messages",
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              splashColor: Colors.blue,
              tooltip: "Post message",
              onPressed: postMsg,
            )));
  }
}
