import 'package:flutter/material.dart';
import 'boxes.dart';

void main() {
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<tmpBox> boxes = [];
  void _addNote() {
    boxes.add(tmpBox(
      msg: "pudlo",
    ));
    setState(() {
      print('Note Added');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your list!'),
      ),
      //body: ListView(
      //padding: const EdgeInsets.all(16),
      //children: [
      // ...boxes.map(buildBox).toList(),
      //],
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MyBox(boxes[index].title);
        },
        itemCount: boxes.length,
        padding: EdgeInsets.all(16.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNote();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
/*
class productList extends StatefulWidget {
  const productList({Key? key}) : super(key: key);

  @override
  State<productList> createState() => _productList();
}

class _productList extends State<productList> {
  List<listData> productList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        children: [
          ...productList.map(productTile()).toList(),
        ],
      ),
    );
  }
}

class productTile extends StatefulWidget {
  bool _value = false;
  String? _title;

  productTile(listData data) {
    _title = data._title;
    _value = data._value;
  }
  @override
  _productTileState createState() => _productTileState(_value, _title);
}

class _productTileState extends State<productTile> {
  bool _value = false;
  String? _title;

  _productTileState(bool checkValue, String? checkTitle) {
    _value = checkValue;
    _title = checkTitle;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        value: _value,
        onChanged: (_value) {
          setState(() {
            _value = _value!;
          });
        },
        title: Text(
          'Wpisz nazwe productu',
          style: TextStyle(
            decoration: _value ? TextDecoration.lineThrough : null,
          ),
        ));
  }
}

class listData {
  final String _title = '';
  final bool _value = false;
  listData(String title, bool value) {
    title = _title;
    value = _value;
  }
}

Widget listContainer(String title) => GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Text(title),
          Butt
        ],
      ),
    );
*/
