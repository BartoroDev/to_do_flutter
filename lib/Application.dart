import 'package:flutter/material.dart';
import 'boxes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}

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
          return MyBox(tiles, index, _deleteNote);
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
    tiles.add("tile ${tiles.length + 1}");
    debugPrint('Note Added');
    setState(() {});
  }

  void _deleteNote(int index) {
    tiles.removeAt(index);
    setState(() {});
  }
}
