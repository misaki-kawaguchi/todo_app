import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
