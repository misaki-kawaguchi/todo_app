import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/models/item_model.dart';
import 'package:todo_app/view_models/item_list_view_model.dart';

class AddItemDialog extends HookConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(text: item.title);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'タイトル'),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  itemListNotifier.addItem(title: textController.text.trim());
                  Navigator.pop(context);
                },
                child: const Text('追加'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
