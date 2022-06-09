import 'package:flutter/material.dart';
import 'package:to_do_flutter/shoppingList.dart';
import 'products.dart';

class tmpBox {
  String title = '';

  tmpBox({String msg = ''}) : title = msg;
}

class MyBox extends StatefulWidget {
  String msg = '';

  MyBox(String title) : msg = title;

  @override
  State createState() => _MyBoxState(msg);
}

class _MyBoxState extends State<MyBox> {
  //List<String> products = ["Marchewka", "Jablko", "Mleko"];
  List<TextEditingController> myControllers = [TextEditingController()];
  Color _boxColor = Colors.blueGrey;
  String _title = '';
  _MyBoxState(String msg) : _title = msg;

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
                //splashFactory: InkSplash.splashFactory,
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
                    Text(_title),
                    Icon(
                      Icons.edit,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.delete,
              size: 30,
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    ));
  }
}
