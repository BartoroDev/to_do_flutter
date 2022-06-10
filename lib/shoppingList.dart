import 'package:flutter/material.dart';
import 'products.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyShoppingList extends StatefulWidget {
  final List<TextEditingController> myControllers;

  const MyShoppingList(this.myControllers, {Key? key}) : super(key: key);

  @override
  State createState() => _ShoppingListState();
}

class _ShoppingListState extends State<MyShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add products!'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ProductController(widget.myControllers[index], _deleteProduct);
        },
        itemCount: widget.myControllers.length,
        padding: const EdgeInsets.all(16.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addProduct(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addProduct() {
    widget.myControllers.add(TextEditingController());
    setState(() {});
  }

  void _deleteProduct(TextEditingController controller) {
    widget.myControllers.remove(controller);
    setState(() {});
  }
}