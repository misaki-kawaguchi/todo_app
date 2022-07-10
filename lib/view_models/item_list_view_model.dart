import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/models/item_model.dart';

// ItemListNotifierの内容を管理するProviderを作成
final itemListProvider =
    StateNotifierProvider<ItemListNotifier, AsyncValue<List<Item>>>((ref) {
  return ItemListNotifier(ref.read);
});

// データの操作を行うクラス
class ItemListNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  ItemListNotifier(this._read) : super(const AsyncValue.loading());

  // 外部からProviderを取得可能にする
  final Reader _read;
}
