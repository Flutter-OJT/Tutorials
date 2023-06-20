import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  final List<Map<String, String>> itemList;

  const MyHome({super.key, required this.itemList});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              return ListTile(
                //title: const Text('Te'),
                title: Text(itemList[index]['title']!),
                subtitle: Text(itemList[index]['description']!),
                //title: Text('Title'),
              );
            },
          ),
        ),
      ],
    );
  }
}
