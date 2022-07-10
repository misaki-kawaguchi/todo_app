import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Firestoreのインスタンスを取得するProvider
final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// ItemRepositoryの内容を管理するProvider
final itemRepositoryProvider =
    Provider<ItemRepository>((ref) => ItemRepository(ref.read));

class ItemRepository {
  const ItemRepository(this._read);
  // 外部からProviderを取得可能にする
  final Reader _read;
}
