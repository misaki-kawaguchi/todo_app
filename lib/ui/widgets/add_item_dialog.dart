import 'package:flutter/material.dart';
import 'package:todo_app/models/item_model.dart';

class AddItemDialog extends StatelessWidget {
  const AddItemDialog({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  // ダイアログを表示
  static void show(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (context) => AddItemDialog(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Text('ダミー'),
    );
  }
}
