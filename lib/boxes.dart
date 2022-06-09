import 'package:flutter/material.dart';
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
  Color _boxColor = Colors.lightBlue;
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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Scaffold(
                          //color: Colors.yellow[100],
                          body: Builder(builder: (BuildContext context) {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return ProductList(myControllers[index]);
                              },
                              itemCount: myControllers.length,
                              padding: EdgeInsets.all(16.0),
                            );
                          }),
                          floatingActionButton: FloatingActionButton(
                            onPressed: () {
                              myControllers.add(TextEditingController());
                              setState(() {});
                            },
                            child: Icon(Icons.add),
                          ),
                        );
                      });
                  setState(() {});
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
