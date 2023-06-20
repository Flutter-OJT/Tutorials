import 'package:flutter/material.dart';
import 'package:todocrudlist/Screens/home_screens.dart';

class MyForm {
  List<Map<String, String>> itemList = []; // List to store the form values
  String title = '';
  String description = '';
  void addDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Create Todo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        // Update the title value
                        title = value;
                      },
                      decoration: const InputDecoration(
                        //borderRadius: BorderRadius.circular(8),

                        hintText: 'Title',
                        border: InputBorder.none,

                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        // Update the description value
                        description = value;
                      },
                      maxLines: 5,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        hintText: 'Description',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            // Perform form submission logic here
                            addItemToList(context, itemList);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Create'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void addItemToList(BuildContext context, List<Map<String, String>> itemList) {
    itemList.add({'title': title, 'description': description});
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHome(
          itemList: itemList,
        ),
      ),
    );
  }
}
