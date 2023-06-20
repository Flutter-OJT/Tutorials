import 'package:flutter/material.dart';
import 'Screens/Todo/todo_form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyMainPage(),
    );
  }
}

class MyMainPage extends StatelessWidget {
  //List<Map<String, String>> itemList = [];

  const MyMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: const Center(
        child: Text('there is no item!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MyForm().addDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
