import 'package:flutter/material.dart';
import 'package:to_do_flutter/data/database_controller.dart';
import 'package:to_do_flutter/data/shopping_list_data.dart';

import '../widgets/shopping_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseController dbController = DatabaseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your list!'),
      ),
      body: FutureBuilder<List<ShoppingList>>(
          initialData: const [],
          future: dbController.getShoppingLists(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return MyTile(snapshot.data![index].title,
                      snapshot.data![index].id!, _deleteNote,
                      key: UniqueKey());
                },
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNote(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNote() async {
    //TODO(mati): editable title of shopping list

    await dbController.insertList(ShoppingList(title: 'New List'));
    setState(() {});
  }

  void _deleteNote(int index) async {
    await dbController.deleteShoppingList(index);
    setState(() {});
  }
}