import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DialogBox extends StatefulWidget {
  final String title;
  final String body;
  final dynamic onpressed;
 const DialogBox({super.key, required this.title, required this.body, this.onpressed});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
        title: Text(widget.title),
        content: Text(widget.body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed:widget.onpressed,
            child: const Text('Confirm'),
          ),
        ],
      );
    }}
