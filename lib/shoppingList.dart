import 'package:flutter/material.dart';
import 'products.dart';

class MyShoppingList extends StatefulWidget {
  List<TextEditingController> MyControllers = [];
  MyShoppingList(List<TextEditingController> controllers)
      : MyControllers = controllers;

  @override
  State createState() => _ShoppingListState(MyControllers);
}

class _ShoppingListState extends State<MyShoppingList> {
  List<TextEditingController> _controllers = [];

  void _addProduct() {
    _controllers.add(TextEditingController());
    setState(() {});
  }

  _ShoppingListState(List<TextEditingController> controllers)
      : _controllers = controllers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add products!'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ProductController(_controllers[index]);
        },
        itemCount: _controllers.length,
        padding: EdgeInsets.all(16.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addProduct(),
        child: Icon(Icons.add),
      ),
    );
  }
}
