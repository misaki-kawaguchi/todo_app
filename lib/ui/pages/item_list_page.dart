import 'package:flutter/material.dart';
import 'package:todo_app/models/item_model.dart';
import 'package:todo_app/ui/widgets/add_item_dialog.dart';

class ItemListPage extends StatelessWidget {
  const ItemListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO App'),
      ),
      floatingActionButton: FloatingActionButton(
        // タスク作成ダイアログを表示
        onPressed: () => AddItemDialog.show(context, Item.empty()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
