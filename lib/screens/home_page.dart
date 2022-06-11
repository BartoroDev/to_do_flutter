import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/shopping_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> tiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your list!'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MyTile(tiles, index, _deleteNote, key: UniqueKey());
        },
        itemCount: tiles.length,
        padding: const EdgeInsets.all(16.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNote(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNote() {
    tiles.add("${tiles.length + 1}");
    setState(() {});
  }

  void _deleteNote(int index) {
    tiles.removeAt(index);
    setState(() {});
  }
}