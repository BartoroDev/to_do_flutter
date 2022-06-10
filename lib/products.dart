import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends StatefulWidget {
  final bool initialValue = false;
  final TextEditingController myController;
  final Function(TextEditingController controller) deleteController;

  const ProductController(this.myController, this.deleteController, {Key? key})
      : super(key: key);

  @override
  State<ProductController> createState() => _ProductControllerState();
}

class _ProductControllerState extends State<ProductController> {
  bool? checkboxValue;

  @override
  Widget build(BuildContext context) {
    checkboxValue = checkboxValue ?? widget.initialValue;
    return CheckboxListTile(
      contentPadding: const EdgeInsets.all(10),
      secondary: IconButton(
          onPressed: () => widget.deleteController(widget.myController),
          icon: const Icon(Icons.delete)),
      controlAffinity: ListTileControlAffinity.leading,
      title: TextField(
        controller: widget.myController,
        style: TextStyle(
          fontSize: 22,
          decoration: checkboxValue! ? TextDecoration.lineThrough : null,
        ),
      ),
      value: checkboxValue,
      onChanged: (newValue) {
        setState(() {
          checkboxValue = newValue ?? checkboxValue;
        });
      },
    );
  }
}