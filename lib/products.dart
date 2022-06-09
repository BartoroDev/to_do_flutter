import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  String msg = '';
  bool value = false;
  TextEditingController _controller;

  ProductList(TextEditingController controller) : _controller = controller;

  @override
  State createState() => _ProductList(_controller, value);
}

class _ProductList extends State<ProductList> {
  TextEditingController _controller;
  bool _value = false;

  _ProductList(TextEditingController controller, bool value)
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
