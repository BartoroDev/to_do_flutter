import 'package:flutter/material.dart';
import 'package:to_do_flutter/screens/product_list.dart';

class MyTile extends StatefulWidget {
  final String title;
  final int myIndex;
  final Function(int) deleteFunction;
  const MyTile(this.title, this.myIndex, this.deleteFunction, {Key? key})
      : super(key: key);

  @override
  State createState() => _MyTileState();
}

class _MyTileState extends State<MyTile> {
  final Color _boxColor = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: MediaQuery.of(context).size.width * 0.6,
              height: 80,
              decoration: BoxDecoration(
                color: _boxColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyShoppingList(listId: widget.myIndex)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.title),
                    const Icon(
                      Icons.edit,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //in progress
                widget.deleteFunction(widget.myIndex);
                setState(() {});
              },
              child: const Icon(
                Icons.delete,
                size: 30,
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
      ],
    ));
  }
}