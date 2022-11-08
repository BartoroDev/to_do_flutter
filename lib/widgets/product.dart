import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_flutter/bloc/product_list_cubit.dart';

import '../data/shopping_list_data.dart';

class ProductController extends StatefulWidget {
  final ProductData product;

  const ProductController({required this.product, Key? key}) : super(key: key);

  @override
  State<ProductController> createState() => _ProductControllerState();
}

class _ProductControllerState extends State<ProductController> {
  @override
  Widget build(BuildContext context) {
    final bool value = widget.product.isChecked == 1 ? true : false;
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(10),
      secondary: IconButton(
          onPressed: () => context
              .read<ProductListCubit>()
              .deleteProduct(widget.product.id!),
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
          onSubmitted: (input) async => context
              .read<ProductListCubit>()
              .updateProductName(widget.product.id!, input)),
      value: value,
      onChanged: (newValue) async => context
          .read<ProductListCubit>()
          .updateProductCheck(widget.product.id!, newValue),
    );
  }
}