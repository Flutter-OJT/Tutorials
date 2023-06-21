import 'package:flutter/material.dart';
import 'package:todocrudlist/Models/Todo/todo_model.dart';
import 'Todo/todo_form_screen.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<Items> itemList = []; // Declare itemList in the state class

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
                      Items currentItem = itemList[index];
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
                                child: IconButton(
                                  onPressed: () {
                                    MyForm(onSave: (updatedItem) {
                                      setState(() {
                                        itemList[index] = updatedItem;
                                        //itemList.removeAt(index);
                                        // itemList.add(updatedItem);
                                        print(updatedItem.title);
                                      });
                                    }).editDialog(context, currentItem.id);
                                  },
                                  color: Colors.white,
                                  icon: const Icon(Icons.edit),
                                ),
                              ),
                              const SizedBox(width: 10),
                              CircleAvatar(
                                backgroundColor: Colors.red,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      itemList.removeAt(index);
                                    });
                                  },
                                  color: Colors.white,
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
        onPressed: () {
          MyForm(onSave: (items) {
            setState(() {
              itemList.add(items);
            });
          }).addDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
