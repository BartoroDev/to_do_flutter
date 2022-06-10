import 'package:flutter/material.dart';

class ProductController extends StatefulWidget {
  final bool initialValue = false;
  final TextEditingController myController;

  const ProductController(TextEditingController controller, {Key? key})
      : myController = controller,
        super(key: key);

  @override
  State<ProductController> createState() => _ProductControllerState();
}

class _ProductControllerState extends State<ProductController> {
  bool? checkboxValue;

  @override
  Widget build(BuildContext context) {
    checkboxValue = checkboxValue ?? widget.initialValue;
    return CheckboxListTile(
      title: TextField(
        controller: widget.myController,
        style: TextStyle(
          decoration: checkboxValue! ? TextDecoration.lineThrough : null,
        ),
      ),
      value: checkboxValue,
      onChanged: (newValue) => setState(() {
        checkboxValue = newValue ?? checkboxValue;
      }),
    );
  }
}
