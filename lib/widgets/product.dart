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
    bool? value = widget.product.isChecked == 1 ? true : false;
    return Container(
      child: CheckboxListTile(
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
          if (newValue == true) {
            await dbController.updateProductCheck(widget.product.id!, 1);
          } else {
            await dbController.updateProductCheck(widget.product.id!, 0);
          }
          ProductData tmp =
              await dbController.getOneProduct(widget.product.id!);
          setState(() {
            widget.product.name = tmp.name;
            widget.product.isChecked = tmp.isChecked;
          });
        },
      ),
    );
  }
}