import 'package:flutter/material.dart';

class TodoFormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController;
  final TextEditingController desController;
  final Function(String, String) onCreate;

  TodoFormScreen({
    required this.titleController,
    required this.desController,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          children: [
            Text('Create To Do'),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: ('Title'),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: desController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: ('Description'),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text.trim();
                String description = desController.text.trim();
                if (title.isNotEmpty && description.isNotEmpty) {
                  onCreate(title, description);
                  Navigator.pop(context);
                }
              },
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
