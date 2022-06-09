import 'package:flutter/material.dart';

class ProductController extends StatefulWidget {
  String msg = '';
  bool value = false;
  TextEditingController _controller;

  ProductController(TextEditingController controller)
      : _controller = controller;

  @override
  State createState() => _ProductController(_controller, value);
}

class _ProductController extends State<ProductController> {
  TextEditingController _controller;
  bool _value = false;

  _ProductController(TextEditingController controller, bool value)
      : _controller = controller,
        _value = value;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: TextField(
          controller: _controller,
          style: TextStyle(
            decoration: _value ? TextDecoration.lineThrough : null,
          ),
        ),
        value: _value,
        onChanged: (_value) {
          setState(() {
            this._value = _value!;
          });
        });
  }
}
