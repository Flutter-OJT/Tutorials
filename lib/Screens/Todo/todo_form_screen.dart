import 'package:flutter/material.dart';
import 'package:todocrudlist/Models/Example/item_model.dart';

import '../Commons/common_widgets.dart';

class MyForm extends StatelessWidget {
  final Function(ItemModel) onSave;
  final String initialTitle;
  final String initialDescription;

  MyForm({
    Key? key,
    required this.initialTitle,
    required this.initialDescription,
    required this.onSave,
  }) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                          final newItem = ItemModel(
                            // Set the id as per your requirement
                            title: _titleController.text,
                            description: _descriptionController.text,
                          );

                          await onSave(newItem);
                          // ignore: use_build_context_synchronously
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
