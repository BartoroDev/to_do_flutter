import 'package:flutter/material.dart';
import 'package:to_do_flutter/shoppingList.dart';
import 'products.dart';

class MyBox extends StatefulWidget {
  List<String> myShoppingLists = [];
  int myIndex;
  MyBox(List<String> shoppingLists, int index)
      : myShoppingLists = shoppingLists,
        myIndex = index;

  @override
  State createState() => _MyBoxState(myShoppingLists, myIndex);
}

class _MyBoxState extends State<MyBox> {
  List<TextEditingController> myControllers = [TextEditingController()];
  Color _boxColor = Colors.blueGrey;
  List<String> _shoppingLists = [];
  int _index;
  _MyBoxState(List<String> shoppingLists, int index)
      : _shoppingLists = shoppingLists,
        _index = index;

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
              duration: Duration(milliseconds: 200),
              width: MediaQuery.of(context).size.width * 0.6,
              height: 80,
              decoration: BoxDecoration(
                color: _boxColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              //podczas animacji rogi tego contenera też się animują, pomimo że ich tam ,,nie ma", jak to naprawic
              child: InkWell(
                splashFactory: InkSplash.splashFactory,
                //splashColor: Colors.pink,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyShoppingList(myControllers)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(_shoppingLists[_index]),
                    Icon(
                      Icons.edit,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //w trakcie dodawania usuwania pudla
                _shoppingLists.removeAt(_index);
                print("Usunolem obiekt");
                setState(() {});
              },
              child: Icon(
                Icons.delete,
                size: 30,
              ),
            )
          ],
        ),
        SizedBox(height: 16),
      ],
    ));
  }
}
