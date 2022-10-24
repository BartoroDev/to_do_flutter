import 'package:flutter/material.dart';

import '../data/database_controller.dart';
import '../data/shopping_list_data.dart';

class ProductController extends StatefulWidget {
  final ProductData product;
  final Function(int id) deleteProduct;

  const ProductController(
      {required this.product, required this.deleteProduct, Key? key})
      : super(key: key);

  @override
  State<ProductController> createState() => _ProductControllerState();
}

class _ProductControllerState extends State<ProductController> {
  DatabaseController dbController = DatabaseController();

  @override
  Widget build(BuildContext context) {
    final bool value = widget.product.isChecked == 1 ? true : false;
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(10),
      secondary: IconButton(
          onPressed: () => widget.deleteProduct(widget.product.id!),
          icon: const Icon(Icons.delete)),
      controlAffinity: ListTileControlAffinity.leading,
      title: TextField(
        decoration: const InputDecoration(
          hintText: 'Add new product',
          border: InputBorder.none,
        ),
        controller: TextEditingController()..text = widget.product.name,
        style: TextStyle(
          fontSize: 22,
          decoration: value ? TextDecoration.lineThrough : null,
        ),
        onSubmitted: (input) async {
          dbController.updateProductName(widget.product.id!, input);
        },
      ),
      value: value,
      onChanged: (newValue) async {
        await dbController.updateProductCheck(
            widget.product.id!, newValue == true ? 1 : 0);
        final productData =
            await dbController.getOneProduct(widget.product.id!);
        setState(() {
          widget.product.name = productData.name;
          widget.product.isChecked = productData.isChecked;
        });
      },
    );
  }
}