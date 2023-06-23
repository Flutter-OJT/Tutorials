import 'package:flutter/material.dart';
import 'package:todo_list/Models/Todo/todo_model.dart';
import 'Todo/todo_form_screen.dart';

///HomeScreen
///
///@author HeinhtetLinn
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  List<ListItem> homes = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();


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
          content: const Text('Are you sure you want to delete this item?',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  homes.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
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
        title: const Text('Todo List'),
        elevation: 3,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
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
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.description,
                      size: 35,
                    ),
                    title: Text(
                      homes[index].title,
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                  return const SingleChildScrollView();
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
            builder: (BuildContext context) {
              return MyTodo(
                onSave: (items) {
                  setState(() {
                    homes.add(items);
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



