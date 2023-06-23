import 'package:flutter/material.dart';
import '../../Models/Todo/todo_model.dart';
import '../Commons/common_widgets.dart';

///MyTodo
///
///@author HeinhtetLinn
class MyTodo extends StatelessWidget {
  final Function(ListItem) onSave;
  final String initialTitle;
  final String initialDescription;

  MyTodo({
    Key? key,
    required this.onSave,
    required this.initialTitle,
    required this.initialDescription,
  }) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = initialTitle;
    _descriptionController.text = initialDescription;

    return ScrollViewWidget(
        formKey: _formKey,
        titleController: _titleController,
        descriptionController: _descriptionController,
        onSave: onSave);
  }
}



