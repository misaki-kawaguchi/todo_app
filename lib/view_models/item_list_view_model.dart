import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/models/item_model.dart';
import 'package:todo_app/repositories/item_repository.dart';

// ItemListNotifierの内容を管理するProviderを作成
final itemListProvider =
    StateNotifierProvider<ItemListNotifier, AsyncValue<List<Item>>>((ref) {
  return ItemListNotifier(ref.read);
});

// データの操作を行うクラス
class ItemListNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  ItemListNotifier(this._read) : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  // 外部からProviderを取得可能にする
  final Reader _read;

  // Item一覧を取得
  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncValue.loading();
    try {
      final items = await _read(itemRepositoryProvider).retrieveItems();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Itemを追加
  Future<void> addItem(
      {required String title, bool isCompleted = false}) async {
    try {
      final item = Item(
        title: title,
        isCompleted: isCompleted,
        createdAt: DateTime.now(),
      );
      // ドキュメントのid
      final itemId = await _read(itemRepositoryProvider).createItem(item: item);
      // item一覧にitemを追加（itemモデルのidにドキュメントのidにコピーする）
      state.whenData(
        (items) => state = AsyncValue.data(
          items
            ..add(
              item.copyWith(id: itemId),
            ),
        ),
      );
    } catch (e) {
      throw e.toString();
    }
  }

  // Itemを更新
  Future<void> updateItem({required Item updateItem}) async {
    try {
      await _read(itemRepositoryProvider).updateItem(item: updateItem);
      state.whenData(
        (items) {
          state = AsyncValue.data([
            for (final item in items)
              if (item.id == updateItem.id) updateItem else item
          ]);
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }

  // Itemを削除
  Future<void> deleteItem({required String itemId}) async {
    try {
      await _read(itemRepositoryProvider).deleteItem(id: itemId);
      state.whenData((items) => state =
          AsyncValue.data(items..removeWhere((item) => item.id == itemId)));
    } catch (e) {
      throw e.toString();
    }
  }
}
