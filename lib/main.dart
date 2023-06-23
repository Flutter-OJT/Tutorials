import 'package:flutter/material.dart';
import 'package:todocrudlist/Models/item.dart';
import 'package:todocrudlist/Screens/home_screens.dart';
import 'package:todocrudlist/services/item_service.dart';
import 'dart:io';

import 'Models/config/entity_manager.dart';

/// The current project path
final projectPath = Directory.current.path;

/// the entiry manager
final entityManager = EntityManager();

/// the user service
final itemsService = ItemService();

void main() async {
  await entityManager.initDatabase([Item.empty()]);
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
  const MyMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyHome(),
    );
  }
}
