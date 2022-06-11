import 'package:flutter/material.dart';
import 'package:to_do_flutter/screens/shoppingList.dart';

class MyTile extends StatefulWidget {
  final List<String> myShoppingLists;
  final int myIndex;
  final Function(int) deleteFunction;
  const MyTile(this.myShoppingLists, this.myIndex, this.deleteFunction,
      {Key? key})
      : super(key: key);

  @override
  State createState() => _MyTileState();
}

class _MyTileState extends State<MyTile> {
  List<TextEditingController> myControllers = [];
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
                          builder: (context) => MyShoppingList(myControllers)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.myShoppingLists[widget.myIndex]),
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