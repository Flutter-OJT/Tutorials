import 'package:flutter/material.dart';
import '../../Models/Todo/todo_model.dart';


class ScrollViewWidget extends StatelessWidget {
  const ScrollViewWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required this.onSave,
  }) : _formKey = formKey, _titleController = titleController, _descriptionController = descriptionController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;
  final Function(ListItem p1) onSave;

  @override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0, top: 34.0),
                  child: Text(
                    'Update Todo',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Title',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    controller: _titleController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Description',
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 42.0,
                        horizontal: 16.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    controller: _descriptionController,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      final updatedTodo = ListItem(
                        id: 1, // Replace with the desired ID value
                        title: _titleController.text,
                        description: _descriptionController.text,
                      );
                      onSave(updatedTodo);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}


}


