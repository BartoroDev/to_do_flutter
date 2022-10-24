import 'package:flutter/material.dart';
import '../data/database_controller.dart';
import '../data/shopping_list_data.dart';
import '../widgets/product.dart';

class MyShoppingList extends StatefulWidget {
  final int listId;

  const MyShoppingList({required this.listId, Key? key}) : super(key: key);

  @override
  State createState() => _ShoppingListState();
}

class _ShoppingListState extends State<MyShoppingList> {
  DatabaseController dbController = DatabaseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new products'),
      ),
      body: FutureBuilder<List<ProductData>>(
          initialData: const [],
          future: dbController.getProducts(widget.listId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  return ProductController(
                    product: snapshot.data![index],
                    deleteProduct: _deleteProduct,
                    key: UniqueKey(),
                  );
                },
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addProduct(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addProduct() async {
    await dbController.insertProduct(
        ProductData(listId: widget.listId, name: '', isChecked: 0));
    setState(() {});
  }

  void _deleteProduct(int id) async {
    await dbController.deleteProduct(id);
    setState(() {});
  }
}