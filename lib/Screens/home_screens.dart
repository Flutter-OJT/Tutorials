import 'package:flutter/material.dart';
import 'package:todocrudlist/Models/Todo/todo_model.dart';
import 'Commons/common_widgets.dart';
import 'Todo/todo_form_screen.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<Item> itemList = []; // Declare itemList in the state class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: itemList.isEmpty
          ? const Center(
              child: Text(
                'No records available!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: const Text(
                    'Hello Flutter',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: itemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Item currentItem = itemList[index];
                      return Card(
                        color: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.note_add,
                            size: 40,
                          ),
                          title: Text(currentItem.title),
                          subtitle: Text(currentItem.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                child: CommonWidget.commonIconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MyForm(
                                          onSave: (items) {
                                            setState(() {
                                              itemList[index] = items;
                                            });
                                          },
                                          //initialTitle: currentItem.title,
                                          // initialDescription:currentItem.description,
                                        );
                                      },
                                    );
                                  },
                                  icon: Icons.edit,
                                ),
                              ),
                              const SizedBox(width: 10),
                              CircleAvatar(
                                backgroundColor: Colors.red,
                                child: CommonWidget.commonIconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Delete Item'),
                                          content: const Text(
                                              'Are you sure you want to delete this item?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  itemList.removeAt(index);
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icons.delete,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return MyForm(
                onSave: (items) {
                  setState(() {
                    itemList.add(items);
                  });
                },
                initialDescription: '',
                initialTitle: '',
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
