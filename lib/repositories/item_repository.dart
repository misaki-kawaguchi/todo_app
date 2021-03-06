import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/models/item_model.dart';

// overrideで値を書き換えられるabstractクラス
abstract class BaseItemRepository {
  Future<List<Item>> retrieveItems();
  Future<String> createItem({required Item item});
  Future<void> updateItem({required Item item});
  Future<void> deleteItem({required String id});
}

// Firestoreのインスタンスを取得するProvider
final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// ItemRepositoryの内容を管理するProvider
final itemRepositoryProvider =
    Provider<ItemRepository>((ref) => ItemRepository(ref.read));

class ItemRepository implements BaseItemRepository {
  const ItemRepository(this._read);
  // 外部からProviderを取得可能にする
  final Reader _read;

  // getメソッドで値を取得する
  @override
  Future<List<Item>> retrieveItems() async {
    try {
      final snap =
          await _read(firebaseFirestoreProvider).collection('lists').get();
      return snap.docs.map((doc) => Item.fromDocument(doc)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  // addメソッドで値を追加する
  @override
  Future<String> createItem({required Item item}) async {
    // listsコレクションにitemを追加
    try {
      final docRef =
          await _read(firebaseFirestoreProvider).collection('lists').add(
                item.toDocument(),
              );
      // ドキュメントのidを返す
      return docRef.id;
    } catch (e) {
      throw e.toString();
    }
  }

  // updateメソッドで値を更新する
  @override
  Future<void> updateItem({required Item item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .collection('lists')
          .doc(item.id)
          .update(item.toDocument());
    } catch (e) {
      throw e.toString();
    }
  }

  // deleteメソッドで値を削除する
  @override
  Future<void> deleteItem({required String id}) async {
    try {
      await _read(firebaseFirestoreProvider).collection('lists').doc(id).delete();
    } catch (e) {
      throw e.toString();
    }
  }
}
