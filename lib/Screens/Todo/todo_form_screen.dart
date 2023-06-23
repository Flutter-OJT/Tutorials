import 'package:flutter/material.dart';
import 'package:todocrudlist/main.dart';
import '../../Models/Todo/todo_model.dart';
import '../../services/item_service.dart';
import '../Commons/common_widgets.dart';

// ignore: must_be_immutable
class MyForm extends StatelessWidget {
  //final Function(Item) onSave;
  final String initialTitle;
  final String initialDescription;
  final ItemService _itemService = ItemService();
  MyForm({
    Key? key,
    required this.initialTitle,
    required this.initialDescription,
  }) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isEditing = initialTitle.isNotEmpty && initialDescription.isNotEmpty;

    if (isEditing) {
      _titleController.text = initialTitle;
      _descriptionController.text = initialDescription;
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    isEditing ? 'Todo Edit' : 'Todo Create',
                    style: CommonWidget.titleText(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String title = _titleController.text;
                          String description = _descriptionController.text;
                          Item newItem = Item(
                            title: title,
                            description: description,
                          );
                          await _itemService.createItem(newItem);
                          Navigator.pop(context);
                        }
                      },
                      style: CommonWidget.primaryButtonStyle().copyWith(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: Text(isEditing ? 'Update' : 'Create'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
