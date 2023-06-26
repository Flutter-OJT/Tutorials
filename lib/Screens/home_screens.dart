import 'package:flutter/material.dart';
import '../Models/Example/item_model.dart';
import '../Repositories/Todo/item_repository.dart';
import 'Commons/common_widgets.dart';
import 'Todo/todo_form_screen.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<ItemModel> itemList = [];
  final ItemRepository _repository = ItemRepository();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataFromDatabase();
  }

  Future<void> fetchDataFromDatabase() async {
    setState(() {
      isLoading = true;
    });

    List<ItemModel>? items = await _repository.list();

    setState(() {
      itemList = items ?? [];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : itemList.isEmpty
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
                          ItemModel item = itemList[index];

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
                              title: Text(item.title.toString()),
                              subtitle: Text(item.description.toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.blueAccent,
                                    child: CommonWidget.commonIconButton(
                                      onPressed: () async {
                                        // ignore: unused_local_variable
                                        final updatedItem =
                                            await showModalBottomSheet<
                                                ItemModel>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return MyForm(
                                              onSave: (updatedItem) async {
                                                await _repository.update(
                                                  updatedItem.id,
                                                  {
                                                    'title': updatedItem.title,
                                                    'description':
                                                        updatedItem.description,
                                                  },
                                                );

                                                setState(() {
                                                  itemList[index] = updatedItem;
                                                });
                                              },
                                              initialTitle: item.title ?? '',
                                              initialDescription:
                                                  item.description ?? '',
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
                                                  onPressed: () async {
                                                    await _repository
                                                        .delete(item.id);
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
                onSave: (newItem) async {
                  int? id = await _repository.create(newItem.toMap());
                  if (id != null) {
                    newItem.id = id;
                    setState(() {
                      itemList.add(newItem);
                    });
                  }
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
