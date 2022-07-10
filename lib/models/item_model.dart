import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

class DateTimeTimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const DateTimeTimestampConverter();

  @override
  // Timestamp型からDateTime型に変換
  DateTime fromJson(Timestamp json) {
    return json.toDate();
  }

  @override
  // DateTime型からTimestamp型に変換
  Timestamp toJson(DateTime object) {
    return Timestamp.fromDate(object);
  }
}

@freezed
class Item with _$Item {
  // コンストラクタ（メソッドやカスタムゲッター、カスタムフィールドを追加可能にする）
  const Item._();

  factory Item({
    String? id,
    required String title,
    @Default(false) bool isCompleted,
    @DateTimeTimestampConverter() required DateTime createdAt,
  }) = _Item;

  // Itemにtitleが入っていない場合
  factory Item.empty() => Item(title: '', createdAt: DateTime.now());

  // Map型に変換する
  factory Item.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Item.fromJson(data).copyWith(id: doc.id);
  }

  // idを削除
  Map<String, dynamic> toDocument() => toJson()..remove('id');

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
