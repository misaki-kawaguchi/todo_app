import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/item_model.dart';
import 'package:todo_app/ui/widgets/add_item_dialog.dart';
import 'package:todo_app/view_models/item_list_view_model.dart';

class ItemListPage extends HookConsumerWidget {
  const ItemListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemList = ref.watch(itemListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO App'),
      ),
      body: itemList.when(
        data: (items) => items.isEmpty
            ? const Center(
                child: Text(
                  'タスクがありません',
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];
                  String getTodayDate() {
                    initializeDateFormatting('ja');
                    return DateFormat('yyyy/MM/dd HH:mm', "ja")
                        .format(item.createdAt);
                  }
                  return Column(
                    children: [
                      ListTile(
                        key: ValueKey(item.id),
                        title: Text(item.title),
                        subtitle: Text(getTodayDate()),
                        trailing: Checkbox(
                          value: item.isCompleted,
                          onChanged: (_) {},
                        ),
                        onTap: () => AddItemDialog.show(context, item),
                        onLongPress: () {},
                      ),
                      const Divider(height: 2),
                    ],
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Text(error.toString()),
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
