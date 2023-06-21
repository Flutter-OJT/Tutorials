import 'package:flutter/material.dart';
import 'package:namer_app/Models/Todo/todo_model.dart';
import 'Todo/todo_form_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  List<TodoModel> todomodel = [];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return TodoFormScreen(
                titleController: titleController,
                desController: desController,
                onCreate: (title, description) {
                  setState(() {
                    titleController.text = '';
                    desController.text = '';
                    todomodel
                        .add(TodoModel(title: title, description: description));
                  });
                },
              );
            },
          ).then((value) {
            titleController.text = '';
            desController.text = '';
          });
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Hello Flutter',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          todomodel.isEmpty
              ? Text(
                  'No Data Yet!!',
                  style: TextStyle(fontSize: 20),
                )
              : Flexible(
                  child: ListView.builder(
                    itemCount: todomodel.length,
                    itemBuilder: (context, index) => getRow(index),
                  ),
                ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text('To do List'),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: SvgPicture.asset(
          'assets/icons/notechecked.svg',
          height: 30,
          width: 30,
        ),
        title: Text(
          todomodel[index].title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text(
          todomodel[index].description,
          style: TextStyle(color: Colors.black),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: IconButton(
                onPressed: () {
                  titleController.text = todomodel[index].title;
                  desController.text = todomodel[index].description;
                  setState(() {
                    selectedIndex = index;
                  });
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 0.6,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            color: Colors.white,
                            child: Column(
                              children: [
                                Text('Update To Do'),
                                SizedBox(
                                  height: 16,
                                ),
                                TextField(
                                  controller: titleController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: ('Title'),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                TextField(
                                  controller: desController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: ('Description'),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    String title = titleController.text.trim();
                                    String description =
                                        desController.text.trim();
                                    if (title.isNotEmpty &&
                                        description.isNotEmpty) {
                                      setState(() {
                                        titleController.text = '';
                                        desController.text = '';
                                        todomodel[selectedIndex].title = title;
                                        todomodel[selectedIndex].description =
                                            description;
                                        // selectedIndex = -1;
                                      });
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('Update'),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: Icon(Icons.edit),
                iconSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Colors.red,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    todomodel.removeAt(index);
                  });
                },
                icon: Icon(Icons.delete),
                iconSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
