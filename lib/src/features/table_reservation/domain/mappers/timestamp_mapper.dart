import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_mappable/dart_mappable.dart';

class TimestampMapper extends SimpleMapper<DateTime> {
  const TimestampMapper();

  @override
  DateTime decode(dynamic value) {
    Timestamp ts = value as Timestamp;
    return ts.toDate().toLocal();
  }

  @override
  dynamic encode(DateTime self) {
    return Timestamp.fromDate(self.toUtc());
  }
}
