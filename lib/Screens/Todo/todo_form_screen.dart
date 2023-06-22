import 'package:flutter/material.dart';

class TodoFormScreen extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController desController;
  final Function(String, String) onCreate;

  TodoFormScreen({
    required this.titleController,
    required this.desController,
    required this.onCreate,
  });

  @override
  State<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends State<TodoFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Create To Do'),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: widget.titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: widget.desController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String title = widget.titleController.text.trim();
                    String description = widget.desController.text.trim();
                    widget.onCreate(title, description);
                    Navigator.pop(context);
                  }
                },
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
