import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_flutter/bloc/product_list_cubit.dart';
import 'package:to_do_flutter/screens/product_list.dart';
import 'package:to_do_flutter/bloc/shopping_list_cubit.dart';

import '../data/database_controller.dart';

class MyTile extends StatefulWidget {
  final String title;
  final int listId;
  const MyTile({required this.title, required this.listId, Key? key})
      : super(key: key);

  @override
  State createState() => _MyTileState();
}

class _MyTileState extends State<MyTile> {
  final Color _boxColor = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    DatabaseController dbController = DatabaseController();

    return Column(
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
                              builder: (context) => BlocProvider(
                                    create: (context) =>
                                        ProductListCubit(listId: widget.listId)
                                          ..getData(),
                                    child: MyProductList(),
                                  )));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Shopping List',
                                border: InputBorder.none,
                              ),
                              controller: TextEditingController()
                                ..text = widget.title,
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                              onSubmitted: (input) async {
                                dbController.updateListTitle(
                                    widget.listId, input);
                              },
                            ),
                          ),
                          const Icon(
                            Icons.edit,
                            size: 30,
                          ),
                        ]),
                  )),
              GestureDetector(
                onTap: () {
                  //in progress
                  context
                      .read<ShoppingListCubit>()
                      .deleteShoppingList(widget.listId);
                  setState(() {});
                },
                child: const Icon(
                  Icons.delete,
                  size: 30,
                ),
              ),
            ]),
        const SizedBox(height: 16),
      ],
    );
  }
}