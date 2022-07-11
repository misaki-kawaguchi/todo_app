import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/models/item_model.dart';

// overrideで値を書き換えられるabstractクラス
abstract class BaseItemRepository {
  Future<List<Item>> retrieveItems();
  Future<String> createItem({required Item item});
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
      final snap = await _read(firebaseFirestoreProvider).collection('lists').get();
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
}
