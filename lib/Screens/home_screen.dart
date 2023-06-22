import 'package:flutter/material.dart';
import 'package:todo_list/Models/Todo/todo_model.dart';

///HomeScreen
///
///@author HeinhtetLinn
class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  List<ListItem> homes = [];
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load existing homes from a database or storage
    homes = loadItems();
  }

  List<ListItem> loadItems() {
    // Simulating loading homes from a database or storage
    return [
      ListItem(id: 1, title: 'Task 1', description: 'Description 1'),
      ListItem(id: 2, title: 'Task 2', description: 'Description 2'),
    ];
  }

  void addHome() {
    final newItem = ListItem(
      id: homes.length + 1,
      title: _titleController.text,
      description: _descriptionController.text,
    );
    setState(() {
      homes.add(newItem);
      _titleController.clear();
      _descriptionController.clear();
    });
  }

  void updateHomeTitle(int index, String newTitle) {
    setState(() {
      homes[index].title = newTitle;
    });
  }

  void updateHomeDescription(int index, String newDescription) {
    setState(() {
      homes[index].description = newDescription;
    });
  }

  void deleteListItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Are you sure you want to delete this item?',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  homes.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        elevation: 3,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Hello Flutter',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: homes.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.blue[100],
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.description,
                      size: 35,
                    ),
                    title: Text(
                      homes[index].title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(homes[index].description),
                    trailing: Wrap(
                      spacing: 12,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue[700],
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 10.0, top: 34.0),
                                            child: Text(
                                              'Update Todo',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                hintText: 'Title',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 16.0),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                              ),
                                              initialValue: homes[index].title,
                                              onChanged: (value) {
                                                updateHomeTitle(index, value);
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                hintText: 'Description',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 42.0,
                                                        horizontal: 16.0),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                              ),
                                              initialValue:
                                                  homes[index].description,
                                              onChanged: (value) {
                                                updateHomeDescription(
                                                    index, value);
                                              },
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Update'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.red[400],
                          child: IconButton(
                            onPressed: () {
                              deleteListItem(index);
                            },
                            icon: const Icon(Icons.delete),
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
        backgroundColor: Colors.blue,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0, top: 34.0),
                        child: Text(
                          'Create Todo',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: 'Title',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: 'Description',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 42.0, horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            addHome();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Create'),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                              Size(80.0, 48.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

